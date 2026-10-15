#!/usr/bin/env bash
# Runs the main scene headless for N frames (default 600) and fails on errors or warnings.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
FRAMES="${1:-600}"
G="$ROOT/tools/godot/godot.sh"
"$G" --headless --path "$ROOT/game" --import >/dev/null 2>&1 || true
LOG="$(mktemp)"
set +e
"$G" --headless --path "$ROOT/game" --quit-after "$FRAMES" >"$LOG" 2>&1
CODE=$?
set -e
cat "$LOG"
if [[ $CODE -ne 0 ]] || grep -Eq '(^|[^A-Z_])(ERROR|SCRIPT ERROR|WARNING):' "$LOG"; then
  echo "SMOKE: FAILED (exit $CODE)" >&2
  exit 1
fi
echo "SMOKE: OK ($FRAMES frames)"
