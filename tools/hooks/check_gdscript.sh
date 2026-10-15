#!/usr/bin/env bash
# Claude Code PostToolUse hook: after an Edit/Write to a .gd file under game/, parse it with Godot.
# A parse error exits 2 so the error is fed back to the agent immediately.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
FILE="$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))' 2>/dev/null)"
case "$FILE" in
  "$ROOT"/game/*.gd) ;;
  *) exit 0 ;;
esac
[[ -f "$FILE" ]] || exit 0
RES="res://${FILE#"$ROOT"/game/}"
OUT="$("$ROOT/tools/godot/godot.sh" --headless --path "$ROOT/game" --check-only -s "$RES" 2>&1)"
if [[ $? -ne 0 ]] || grep -q "SCRIPT ERROR" <<<"$OUT"; then
  echo "GDScript check failed for $RES:" >&2
  grep -E "SCRIPT ERROR|ERROR|at:" <<<"$OUT" >&2
  exit 2
fi
exit 0
