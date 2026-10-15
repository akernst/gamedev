#!/usr/bin/env bash
# Captures a scene at common phone sizes (portrait) into <out_dir>/<w>x<h>.png.
#   tools/godot/screens.sh res://scenes/main.tscn out/sizes [sizes]
# Default sizes: 720x1280 (16:9), 1080x2340 (19.5:9), 1080x2400 (20:9), 1170x2532 (iPhone), 1536x2048 (tablet).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCENE="$1"; OUT="$2"; SIZES="${3:-720x1280,1080x2340,1080x2400,1170x2532,1536x2048}"
mkdir -p "$OUT"
OUT_ABS="$(cd "$OUT" && pwd)"
G="$ROOT/tools/godot/godot.sh"
"$G" --headless --path "$ROOT/game" --import >/dev/null 2>&1 || true
CMD=("$G" --path "$ROOT/game" --rendering-driver opengl3 --audio-driver Dummy -s res://tests/support/screen_capture.gd -- --scene "$SCENE" --out "$OUT_ABS" --sizes "$SIZES")
if [[ -z "${DISPLAY:-}" ]] && command -v xvfb-run >/dev/null; then
  xvfb-run -a -s "-screen 0 2048x2560x24" "${CMD[@]}"
else
  "${CMD[@]}"
fi
