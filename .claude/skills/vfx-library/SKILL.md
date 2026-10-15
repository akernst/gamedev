---
name: vfx-library
description: Maintain the catalog of effects so they are reused and varied, not rebuilt. Use whenever an effect is added or changed.
---
# VFX library

`docs/vfx/catalog.md` has one row per effect:

| Effect | Scene | Tags | Parameters | Preview | Particles (peak) | Cost (ms) | Used by |

Tags describe purpose and look (`reward`, `tap`, `unlock`, `ambient`, `small`, `loud`). Before creating anything, search here. When an effect is changed, update every row that uses it.
