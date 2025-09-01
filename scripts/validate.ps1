$ErrorActionPreference = "Stop"

function Assert($cond, $msg) {
  if (-not $cond) { throw $msg }
}

Write-Host "Validating databricks.json..."

$path = Join-Path $PSScriptRoot "..\databricks.json"
Assert (Test-Path $path) "databricks.json not found at repo root"

$json = Get-Content $path -Raw | ConvertFrom-Json

# Required keys
$required = @('version','url','hash','bin')
$missing = @()
foreach ($k in $required) { if (-not $json.PSObject.Properties.Name.Contains($k)) { $missing += $k } }
Assert ($missing.Count -eq 0) ("Missing required keys: " + ($missing -join ', '))

# Version format
$version = [string]$json.version
Assert ($version -match '^\d+\.\d+\.\d+$') "version should look like 0.0.0, got: $version"

# URL includes version
$url = [string]$json.url
Write-Host "version=$version"
Write-Host "url=$url"
Assert ($url.StartsWith('https://')) "url must be https"
$patTag = "*/v$version/*"
$patFile = "*_${version}_*"
Write-Host "patTag=$patTag patFile=$patFile"
$hasTag = $url -like $patTag
$hasFileVer = $url -like $patFile
Write-Host "hasTag=$hasTag hasFileVer=$hasFileVer"
Assert ($hasTag -or $hasFileVer) "url should reference version $version; got: $url"

# autoupdate
Assert ($null -ne $json.autoupdate) "autoupdate block required"
Assert ([string]$json.autoupdate.url -like '*$version*') "autoupdate.url should include $version"
if ($null -ne $json.autoupdate.hash -and $null -ne $json.autoupdate.hash.url) {
  Assert ([string]$json.autoupdate.hash.url -like '*$version*') "autoupdate.hash.url should include $version"
}

# hash format (64 hex, optional 'sha256:' prefix)
$hash = [string]$json.hash
Assert ($hash -match '^(sha256:)?[0-9a-fA-F]{64}$') "hash must be 64 hex chars, optionally prefixed with 'sha256:'"

Write-Host "OK: manifest looks consistent" -ForegroundColor Green
