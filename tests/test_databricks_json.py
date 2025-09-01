import json
import re
from pathlib import Path


def load_manifest():
    p = Path(__file__).resolve().parents[1] / "databricks.json"
    assert p.exists(), "databricks.json not found at repo root"
    data = json.loads(p.read_text(encoding="utf-8"))
    assert isinstance(data, dict), "Manifest must be a JSON object"
    return data


def test_required_keys_present():
    m = load_manifest()
    required = {"version", "url", "hash", "bin"}
    missing = [k for k in required if k not in m]
    assert not missing, f"Missing required keys: {missing}"


def test_version_format_semver_like():
    m = load_manifest()
    version = m.get("version", "")
    assert isinstance(version, str) and version, "version must be a non-empty string"
    assert re.match(r"^\d+\.\d+\.\d+$", version), f"version should look like 0.0.0, got: {version}"


def test_url_contains_version():
    m = load_manifest()
    version = m["version"]
    url = m.get("url", "")
    assert isinstance(url, str) and url.startswith("https://"), "url must be an https URL"
    # Accept either /v{version}/ in path or _{version}_ in filename
    has_tag = f"/v{version}/" in url
    has_filename_ver = f"_{version}_" in url
    assert has_tag or has_filename_ver, (
        f"url should reference version {version} (tag or filename); got: {url}"
    )


def test_autoupdate_uses_version_variable():
    m = load_manifest()
    autoupdate = m.get("autoupdate", {})
    assert isinstance(autoupdate, dict) and autoupdate, "autoupdate block required"
    au_url = autoupdate.get("url", "")
    assert "$version" in au_url, "autoupdate.url should include $version"
    au_hash = autoupdate.get("hash", {})
    if isinstance(au_hash, dict):
        au_hash_url = au_hash.get("url", "")
        assert "$version" in au_hash_url, "autoupdate.hash.url should include $version"


def test_hash_format_sha256():
    m = load_manifest()
    h = m.get("hash", "")
    assert isinstance(h, str) and h, "hash must be a non-empty string"
    # Support either raw hex or 'sha256:HEX'
    ok = bool(re.match(r"^(sha256:)?[0-9a-fA-F]{64}$", h))
    assert ok, "hash must be 64 hex chars, optionally prefixed with 'sha256:'"
