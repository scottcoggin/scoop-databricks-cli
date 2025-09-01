# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Scoop bucket repository for the Databricks CLI. It contains a single JSON manifest file (`databricks.json`) that defines how to install and update the Databricks CLI via the Scoop package manager on Windows.

## Key Files

- `databricks.json` - Main Scoop manifest defining the package installation, version, download URL, hash verification, and auto-update configuration
- `README.md` - Installation and usage instructions for end users
- `tests/test_databricks_json.py` - Python validation tests for manifest structure and consistency
- `scripts/validate.ps1` - PowerShell validation script for manifest verification
- `scripts/verify_download_hash.ps1` - PowerShell script to download and verify SHA256 hash

## Repository Architecture

This is a Scoop bucket repository with a simple structure:
- **Root**: `databricks.json` manifest file defining package metadata and installation
- **Validation**: Python tests (`tests/`) and PowerShell scripts (`scripts/`) ensure manifest consistency
- **Documentation**: `README.md` for users, `CLAUDE.md` for development guidance
- **No source code**: This repository only contains package distribution configuration, not the actual CLI source

## Validation and Testing Commands

### Validate Manifest
- **PowerShell**: `.\scripts\validate.ps1` - Comprehensive validation including JSON structure, required keys, version format, URL consistency, and autoupdate configuration
- **Python**: `pytest tests/` - Python-based tests for manifest structure validation with detailed assertions
- **Quick JSON check**: `Get-Content databricks.json | ConvertFrom-Json > $null`

### Hash Verification
- **Automated script**: `.\scripts\verify_download_hash.ps1` - Downloads the actual release binary and verifies the SHA256 hash matches the manifest (creates `tmp/` directory)
- **Manual verification**: `Invoke-WebRequest <url> -OutFile tmp.zip; Get-FileHash tmp.zip -Algorithm SHA256`

### Local Testing
- **Install locally**: `scoop bucket add databricks-cli <path-to-repo>; scoop install databricks`
- **Force reinstall**: `scoop update databricks -f --no-cache`
- **Uninstall**: `scoop uninstall databricks`

## Common Operations

### Updating the Databricks CLI Version
To update to a new version of the Databricks CLI:
1. Update the `version` field in `databricks.json`
2. Update the `url` field with the new release download URL  
3. Update the `hash` field with the new SHA256 hash (use `verify_download_hash.ps1` to get correct hash)
4. Run `.\scripts\validate.ps1` to ensure manifest consistency
5. Run `pytest tests/` to verify all validation tests pass
6. Test locally with `scoop install databricks` after adding the bucket

### Manifest Structure Requirements
- Must include required keys: `version`, `url`, `hash`, `bin`
- Version must follow semver format (e.g., `0.233.0`)
- URL must reference the version either in path (`/v{version}/`) or filename (`_{version}_`)
- Hash must be 64-character SHA256 (optionally prefixed with `sha256:`)
- `autoupdate` section must use `$version` variable in URLs

## Package Management Context

This repository is specifically for Windows users who use the Scoop package manager. The actual Databricks CLI source code and development happens in the upstream repository at https://github.com/databricks/cli.