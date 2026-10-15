---
name: economy-sim
description: Fast-forward the economy through hours or days of play for several player types and chart time to each milestone. Use for any change to costs, income or progression.
---
# Economy sim

The economy's logic must be runnable without scenes. The simulator (`game/tests/sim/economy_sim.gd`, created with the first economy feature) steps the economy in fixed ticks for each strategy (`active`, `idle`, `returning`) and records time to each milestone in `docs/design/economy.md`.

```bash
tools/godot/godot.sh --headless --path game -s res://tests/sim/economy_sim.gd -- --hours 48
```

Output: a Markdown table to `docs/qa/economy/<date>.md` (milestone x strategy -> time) and a CSV for charts. Pacing targets that miss by more than the tolerance in `economy.md` fail the gate.
