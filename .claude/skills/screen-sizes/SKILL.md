---
name: screen-sizes
description: Capture every screen at common phone sizes and aspect ratios to catch clipped or unreadable UI. Use for UI changes.
---
# Screen sizes

```bash
tools/godot/screens.sh res://scenes/main.tscn out/sizes                      # default phone and tablet sizes
tools/godot/screens.sh res://ui/shop.tscn out/sizes 720x1280,1080x2400       # custom list
```

Default sizes (portrait): 720x1280 (16:9), 1080x2340 (19.5:9), 1080x2400 (20:9), 1170x2532 (iPhone), 1536x2048 (tablet 4:3). Each PNG is the game's own render buffer at base resolution, widened or heightened by `stretch/aspect = expand` (for example 180x400 on a 20:9 phone), which is exactly what the layout has to cope with.

Look at every image. Check: nothing clipped or overlapping, text readable, primary buttons in the lower thumb zone, nothing important in the top ~5% where notches sit (safe areas are verified on a real device by the platform engineer).
