#!/usr/bin/env bash
# Runs a scene for N frames and prints a JSON performance summary.
#   tools/godot/perf.sh res://scenes/main.tscn [frames]
# Headless by default (script cost only). PERF_DISPLAY=1 renders (needs a display or xvfb-run).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCENE="$1"; FRAMES="${2:-600}"
G="$ROOT/tools/godot/godot.sh"
"$G" --headless --path "$ROOT/game" --import >/dev/null 2>&1 || true
ARGS=(--path "$ROOT/game" -s res://tests/support/perf_probe.gd -- --scene "$SCENE" --frames "$FRAMES")
if [[ "${PERF_DISPLAY:-0}" == "1" ]]; then
  if [[ -z "${DISPLAY:-}" ]] && command -v xvfb-run >/dev/null; then
    xvfb-run -a "$G" --rendering-driver opengl3 --audio-driver Dummy "${ARGS[@]}"
  else
    "$G" --rendering-driver opengl3 --audio-driver Dummy "${ARGS[@]}"
  fi
else
  "$G" --headless "${ARGS[@]}"
fi
