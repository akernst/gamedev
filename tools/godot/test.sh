#!/usr/bin/env bash
# Runs the headless test suite. Optional first argument filters test files by path substring.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
G="$ROOT/tools/godot/godot.sh"
"$G" --headless --path "$ROOT/game" --import >/dev/null 2>&1 || true
"$G" --headless --path "$ROOT/game" -s res://tests/runner.gd -- "${1:-}"
