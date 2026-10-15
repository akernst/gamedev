#!/usr/bin/env bash
# Exports a build for a preset in game/export_presets.cfg.
#   tools/godot/export.sh "Android" build/game.apk [--release]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PRESET="$1"; OUT="$2"; MODE="${3:---debug}"
mkdir -p "$(dirname "$OUT")"
OUT_ABS="$(cd "$(dirname "$OUT")" && pwd)/$(basename "$OUT")"
"$ROOT/tools/godot/install.sh" --templates >/dev/null
G="$ROOT/tools/godot/godot.sh"
"$G" --headless --path "$ROOT/game" --import >/dev/null 2>&1 || true
case "$MODE" in
  --release) FLAG=--export-release ;;
  *) FLAG=--export-debug ;;
esac
"$G" --headless --path "$ROOT/game" "$FLAG" "$PRESET" "$OUT_ABS"
test -s "$OUT_ABS"
echo "Exported $PRESET to $OUT_ABS ($(du -h "$OUT_ABS" | cut -f1))"
