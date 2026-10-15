---
name: sprite-import
description: Import sprites with pixel-art settings and check naming, size and licence. Use whenever an image is added under game/.
---
# Sprite import

- Project default filter is nearest (`rendering/textures/canvas_textures/default_texture_filter = 0`); do not override per node.
- No mipmaps, lossless compression for pixel art.
- Name: `snake_case`, grouped by area (`game/art/ui/`, `game/art/items/`).
- Sizes are multiples of the base tile size in the style guide.
- Run `python3 tools/palette_check.py <file>` and `python3 tools/licence_audit.py`.
