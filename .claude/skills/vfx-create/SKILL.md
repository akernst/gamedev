---
name: vfx-create
description: Build an effect as a parameterised, reusable scene from library building blocks. Use after vfx-find.
---
# VFX create

- Scene: `game/vfx/<name>.tscn`, root script `game/vfx/<name>.gd` with `@export` parameters (colour, scale, intensity, duration) and a `play()` method; it frees or pools itself when done.
- Building blocks (create in `game/vfx/lib/` as needed): pixel particle presets (`CPUParticles2D` is the safe default on mobile), flipbook sprite, flash overlay, ring/shockwave, trail, `juice-kit` calls (shake, pop-up, squash).
- Snap to whole pixels; use the palette; no smooth gradients unless the style guide allows them.
- Respect the particle budget; prefer fewer, bigger, readable particles.
