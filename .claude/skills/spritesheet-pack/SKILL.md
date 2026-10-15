---
name: spritesheet-pack
description: Pack sprites into atlases to cut draw calls and app size. Use when a screen shows many separate small textures.
---
# Spritesheet pack

Prefer authoring sheets in Aseprite. For loose PNGs, pack with Godot's `AtlasTexture` resources or a sheet built by a script in `tools/`. Keep atlases at or below 2048x2048 for mobile. Measure draw calls before and after with `perf-capture` (display run).
