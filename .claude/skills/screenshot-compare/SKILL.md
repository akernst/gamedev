---
name: screenshot-compare
description: Compare captured frames with approved golden images and report differences. Use in QA for visual regressions.
---
# Screenshot compare

```bash
tools/godot/capture.sh res://tests/visual/<scene>.tscn out/visual/<scene> 2
python3 tools/screenshot_compare.py out/visual/<scene> game/tests/goldens/<scene> --threshold 0.001
```

Reports, per image, the fraction of differing pixels and writes a diff PNG next to the actual. Goldens are updated only on purpose: `--update` copies actuals over goldens, and the PR must say why.
