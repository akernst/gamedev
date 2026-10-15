---
name: style-check
description: Compare screenshots against the style guide and reference board and list deviations. Use for art director reviews.
---
# Style check

1. Read `docs/design/style-guide.md` and the feature's reference board.
2. Look at each capture. Run `python3 tools/palette_check.py` on them.
3. Check: pixel scale consistent, palette, outline rules, font, spacing, VFX loudness relative to the rest of the screen.
4. Verdict: **on-style**, or numbered concrete changes with the file and what to change.
