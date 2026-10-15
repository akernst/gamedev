---
name: run-game
description: Run a scene headless for a number of frames to catch runtime errors, or with a display to capture frames. Use for smoke runs and before visual checks.
---
# Run game

- Smoke: `tools/godot/smoke.sh [frames]` runs the main scene headless (default 600 frames) and fails on any `ERROR`, `SCRIPT ERROR` or `WARNING` line in the output.
- Frames to PNG: `tools/godot/capture.sh res://path/scene.tscn out/dir [frames]` uses Godot's movie writer at a fixed 60 fps and needs a display (`xvfb-run` is used automatically when available). Read the PNGs you produce.
- Scripted input: see `input-replay`.
