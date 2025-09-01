# Repository Guidelines

## Project Structure & Module Organization
- Root: `databricks.json` (Scoop manifest for Databricks CLI)
- Docs: `README.md`, `LICENSE`, and this guide
- Tests: `tests/` (add validations for the manifest here)
- No compiled code in this repo; it’s a Scoop bucket only.

## Build, Test, and Development Commands
- Validate JSON (PowerShell): `Get-Content databricks.json | ConvertFrom-Json > $null`
- Install locally via Scoop: `scoop install databricks` (after adding bucket)
- Reinstall/force update: `scoop update databricks -f --no-cache`
- Uninstall: `scoop uninstall databricks`
- Check URL/hash quickly: `Invoke-WebRequest <url> -OutFile tmp.zip; Get-FileHash tmp.zip -Algorithm SHA256`

## Coding Style & Naming Conventions
- Manifest: strict JSON, 4‑space indent, no trailing commas.
- Keys follow Scoop conventions: `version`, `url`, `hash`, `bin`, `checkver`, `autoupdate`.
- File naming: one app per file; keep `databricks.json` matching the package name.
- Hash: SHA256 in hex; keep consistent casing.
- Keep URLs/version fields in sync across `version`, `url`, and `autoupdate`.

## Testing Guidelines
- Add lightweight tests under `tests/` to assert manifest consistency (e.g., version matches URLs, required keys present).
- Example: `pytest -q` (if you add Python tests).
- Manual check: run the Scoop commands above to install and launch `databricks`.

## Commit & Pull Request Guidelines
- Commit style: imperative and scoped. Examples:
  - `chore: bump databricks to v0.233.0`
  - `fix: correct SHA256 for v0.233.0 archive`
- PR checklist:
  - Update `version`, `url`, `hash`, and `autoupdate` together.
  - Include install log or `Get-FileHash` output for verification.
  - Note breaking changes or upstream release notes.

## Security & Configuration Tips
- Never commit tokens or user config (e.g., `.databrickscfg`).
- Always verify download hashes from upstream artifacts before updating the manifest.
