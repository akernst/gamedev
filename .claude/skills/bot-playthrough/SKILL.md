---
name: bot-playthrough
description: Run scripted bots through the game and log telemetry. Use for playtest analysis.
---
# Bot playthrough

Bots are scripts in `game/tests/bots/` driving the game's logic layer directly (faster than input) with a strategy: `active` (acts every second), `idle` (acts on return only), `returning` (two sessions a day). They log JSON lines (time, currency, purchases, milestone reached) to `out/bots/<strategy>.jsonl`.

Run: `tools/godot/godot.sh --headless --path game -s res://tests/bots/run_bot.gd -- --strategy active --hours 6` (the runner is created with the first economy feature). Summarise against pacing targets.
