---
name: vfx-preview
description: Render an effect in isolation to frames, look at them, and measure its cost. Use before handing back any effect.
---
# VFX preview

1. Create `game/tests/visual/vfx_<name>_preview.tscn` with the effect centred on a neutral background and auto-playing.
2. `tools/godot/capture.sh res://tests/visual/vfx_<name>_preview.tscn out/vfx/<name> 60`
3. Look at the frames (read the PNGs). Check timing, readability at phone size, palette.
4. `tools/godot/perf.sh res://tests/visual/vfx_<name>_preview.tscn 120` for cost.
5. Add or update the catalog entry with the preview path and cost.
