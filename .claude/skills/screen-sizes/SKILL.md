---
name: screen-sizes
description: Capture every screen at common phone sizes and aspect ratios, including notches, to catch clipped or unreadable UI. Use for UI changes.
---
# Screen sizes

Sizes (portrait): 720x1280 (16:9), 1080x2340 (19.5:9), 1080x2400 (20:9), 1170x2532 (iPhone), 1536x2048 (tablet 4:3).

```bash
for s in 720x1280 1080x2340 1080x2400 1170x2532 1536x2048; do
  tools/godot/capture.sh res://scenes/main.tscn out/sizes/$s 30 --resolution $s
done
```

Look at the last frame of each. Check: nothing clipped, safe areas respected, text readable, primary buttons reachable with a thumb.
