#!/usr/bin/env bash
# Runs the pinned Godot binary, installing it on first use. All args are passed through.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
BIN="$("$ROOT/tools/godot/install.sh" --print-path)"
exec "$BIN" "$@"
