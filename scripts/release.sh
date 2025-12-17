#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: scripts/release.sh [--dry-run] <version>" >&2
  exit 1
fi

DRY_RUN=0
VERSION_ARG=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -*)
      echo "Unknown flag $1" >&2
      exit 1
      ;;
    *)
      VERSION_ARG="$1"
      shift
      ;;
  esac
done

if [[ -z "$VERSION_ARG" ]]; then
  echo "Version argument missing" >&2
  exit 1
fi

VERSION=${VERSION_ARG#v}
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must be plain SemVer (e.g. 1.2.3)" >&2
  exit 1
fi

RELEASE_DATE=$(date -u +%Y-%m-%d)

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[dry-run] Would update manifests/CHANGELOG to version $VERSION"
else
  echo "Updating manifests to version $VERSION"
  VERSION="$VERSION" RELEASE_DATE="$RELEASE_DATE" python - <<'PY'
import os
import pathlib
import re
import sys

root = pathlib.Path(__file__).resolve().parents[1]
version = os.environ["VERSION"]
release_date = os.environ["RELEASE_DATE"]

def replace_version(path: pathlib.Path) -> None:
    text = path.read_text(encoding="utf-8")
    new_text, count = re.subn(r'^version\s*=\s*"[^"]+"', f'version = "{version}"', text, count=1, flags=re.MULTILINE)
    if count != 1:
        raise SystemExit(f"Failed to update version in {path}")
    path.write_text(new_text, encoding="utf-8")

replace_version(root / "extension" / "extension.toml")
replace_version(root / "extension" / "Cargo.toml")

changelog = root / "CHANGELOG.md"
lines = changelog.read_text(encoding="utf-8").splitlines()
header = f"## [{version}] - {release_date}"
if header not in lines:
    try:
        idx = next(i for i, line in enumerate(lines) if line.strip() == "## [Unreleased]")
    except StopIteration:
        raise SystemExit("CHANGELOG is missing an [Unreleased] section")
    insertion = ["", header, "", "### Added", "- Describe the highlights for this release", ""]
    lines = lines[: idx + 1] + insertion + lines[idx + 1 :]
    changelog.write_text("\n".join(lines) + "\n", encoding="utf-8")
PY
fi

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[dry-run] Would ensure wasm32-wasip1 target and run cargo fmt/check/build"
else
  echo "Ensuring wasm32-wasip1 target is installed"
  rustup target add wasm32-wasip1 >/dev/null

  pushd extension > /dev/null
  cargo fmt
  cargo check
  cargo build --release --target wasm32-wasip1
  popd > /dev/null
fi

ARTIFACT=extension/target/wasm32-wasip1/release/zed_markdoc_extension.wasm
if [[ $DRY_RUN -eq 1 ]]; then
  echo "[dry-run] Would copy $ARTIFACT to extension/extension.wasm"
elif [[ -f "$ARTIFACT" ]]; then
  cp "$ARTIFACT" extension/extension.wasm
else
  echo "Expected artifact $ARTIFACT not found" >&2
  exit 1
fi

echo
cat <<INFO
Release prep complete for v$VERSION.
- $( [[ $DRY_RUN -eq 1 ]] && echo "[dry-run] Would update" || echo "Updated" ) extension manifests and CHANGELOG
- $( [[ $DRY_RUN -eq 1 ]] && echo "[dry-run] Would build" || echo "Built" ) extension/extension.wasm (ignored by git)
Next steps:
1. Review CHANGELOG entry and commit the changes.
2. Tag the commit (git tag v$VERSION) and push tag.
3. The release GitHub Action will publish to the Zed registry.
INFO
