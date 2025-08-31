# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Scoop bucket repository for the Databricks CLI. It contains a single JSON manifest file (`databricks.json`) that defines how to install and update the Databricks CLI via the Scoop package manager on Windows.

## Key Files

- `databricks.json` - Main Scoop manifest defining the package installation, version, download URL, hash verification, and auto-update configuration
- `README.md` - Installation and usage instructions for end users

## Repository Structure

This repository follows the standard Scoop bucket format:
- The root contains a single JSON manifest file named after the package
- The manifest includes version tracking, download URLs, hash verification, and auto-update rules
- No build scripts, tests, or source code - this is purely a package distribution configuration

## Common Operations

### Updating the Databricks CLI Version
To update to a new version of the Databricks CLI:
1. Update the `version` field in `databricks.json`
2. Update the `url` field with the new release download URL
3. Update the `hash` field with the new SHA256 hash
4. Update any version-specific URLs in the `autoupdate` section if needed

### Verification
The package uses SHA256 hash verification to ensure download integrity. Always verify the hash matches the actual release file when updating versions.

## Package Management Context

This repository is specifically for Windows users who use the Scoop package manager. The actual Databricks CLI source code and development happens in the upstream repository at https://github.com/databricks/cli.