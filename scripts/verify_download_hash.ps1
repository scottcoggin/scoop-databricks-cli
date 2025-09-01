$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force tmp | Out-Null

$m = Get-Content -Raw (Join-Path $PSScriptRoot "..\databricks.json") | ConvertFrom-Json
$ver = [string]$m.version
$url = "https://github.com/databricks/cli/releases/download/v${ver}/databricks_cli_${ver}_windows_amd64.zip"
$out = Join-Path $PSScriptRoot ("..\tmp\databricks_cli_{0}_windows_amd64.zip" -f $ver)

Write-Host "Downloading $url ..."
Invoke-WebRequest $url -OutFile $out

$h = Get-FileHash $out -Algorithm SHA256
$manifestHashRaw = [string]$m.hash
$manifestHash = ($manifestHashRaw -replace '^sha256:','')

Write-Host ("Computed SHA256:    {0}" -f $h.Hash)
Write-Host ("Manifest SHA256:    {0}" -f $manifestHash.ToUpper())

if ($h.Hash.ToUpper() -eq $manifestHash.ToUpper()) {
  Write-Host "MATCH: hash verified" -ForegroundColor Green
  exit 0
} else {
  Write-Host "MISMATCH: update manifest hash" -ForegroundColor Yellow
  exit 2
}
