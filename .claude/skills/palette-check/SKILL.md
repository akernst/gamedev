---
name: palette-check
description: Flag pixels outside the game palette and images with semi-transparent edges. Use on every new or changed pixel-art image.
---
# Palette check

```bash
python3 tools/palette_check.py game/art/**/*.png            # palette from docs/design/palette.hex
python3 tools/palette_check.py --palette other.hex img.png
```

`palette.hex` is one hex colour per line (Lospec format). The tool reports, per image, the off-palette colours and how many pixels use them, and any partially transparent pixels (usually a sign of filtered scaling). Exit code is non-zero if anything is off.
