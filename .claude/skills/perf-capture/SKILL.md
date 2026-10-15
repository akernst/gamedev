---
name: perf-capture
description: Measure frame time, memory, object and draw counts for a scene against the budgets in CLAUDE.md. Use when a change could affect performance and in optimisation work.
---
# Perf capture

```bash
tools/godot/perf.sh res://scenes/main.tscn 600
```

Runs the scene for N frames (headless by default; set `PERF_DISPLAY=1` with a display for real render numbers), then prints a JSON summary: average and worst process time per frame (ms), static memory (MB), object and node counts, and draw calls when rendering. Save results under `docs/perf/` and compare with the budgets table in `CLAUDE.md`.

Headless numbers measure script cost only; GPU cost needs a real device or a display run.
