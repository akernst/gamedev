#!/usr/bin/env bash
# Renders a scene for N frames at a fixed 60 fps and writes PNG frames.
#   tools/godot/capture.sh res://scenes/main.tscn out/main [frames] [extra godot args, e.g. --resolution 720x1280]
# Needs a display; uses xvfb-run when DISPLAY is unset and xvfb-run is installed.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCENE="$1"; OUT="$2"; FRAMES="${3:-60}"; shift $(( $# < 3 ? $# : 3 ))
mkdir -p "$OUT"
OUT_ABS="$(cd "$OUT" && pwd)"
G="$ROOT/tools/godot/godot.sh"
"$G" --headless --path "$ROOT/game" --import >/dev/null 2>&1 || true
CMD=("$G" --path "$ROOT/game" --rendering-driver opengl3 --fixed-fps 60 --write-movie "$OUT_ABS/frame.png" --quit-after "$FRAMES" "$@" "$SCENE")
if [[ -z "${DISPLAY:-}" ]] && command -v xvfb-run >/dev/null; then
  xvfb-run -a -s "-screen 0 1920x1080x24" "${CMD[@]}"
else
  "${CMD[@]}"
fi
echo "Frames written to $OUT_ABS"
