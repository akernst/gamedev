#!/usr/bin/env bash
# Installs the Godot version pinned in GODOT_VERSION into .godot-bin/<version>/.
#   tools/godot/install.sh               install the editor/runtime binary, print its path
#   tools/godot/install.sh --templates   also install export templates (large download)
#   tools/godot/install.sh --print-path  install if needed, print only the path
# Override the install root with GODOT_HOME (CI caches this directory).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
VERSION="$(tr -d '[:space:]' < "$ROOT/GODOT_VERSION")"
TAG="${VERSION}-stable"
HOME_DIR="${GODOT_HOME:-$ROOT/.godot-bin}"
DIR="$HOME_DIR/$VERSION"
BIN="$DIR/Godot_v${TAG}_linux.x86_64"
BASE="https://github.com/godotengine/godot/releases/download/${TAG}"

log() { if [[ "${1:-}" != "--quiet" ]]; then echo "$@" >&2; fi; }

if [[ ! -x "$BIN" ]]; then
  mkdir -p "$DIR"
  echo "Downloading Godot ${TAG}..." >&2
  curl -fsSL -o "$DIR/godot.zip" "$BASE/Godot_v${TAG}_linux.x86_64.zip"
  (cd "$DIR" && unzip -o -q godot.zip && rm godot.zip)
  chmod +x "$BIN"
fi

if [[ "${1:-}" == "--templates" ]]; then
  TPL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/godot/export_templates/${VERSION}.stable"
  if [[ ! -f "$TPL_DIR/version.txt" ]]; then
    echo "Downloading export templates for ${TAG} (large)..." >&2
    TMP="$(mktemp -d)"
    curl -fsSL -o "$TMP/templates.tpz" "$BASE/Godot_v${TAG}_export_templates.tpz"
    (cd "$TMP" && unzip -q templates.tpz)
    mkdir -p "$TPL_DIR"
    cp -r "$TMP/templates/." "$TPL_DIR/"
    rm -rf "$TMP"
  fi
  echo "Export templates: $TPL_DIR" >&2
fi

if [[ "${1:-}" == "--print-path" ]]; then
  echo "$BIN"
else
  "$BIN" --version >&2
  echo "$BIN"
fi
