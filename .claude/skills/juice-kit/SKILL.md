---
name: juice-kit
description: Shared game-feel helpers used the same way everywhere: number pop-ups, coin arcs, button squash, hit-stop, screen shake, haptics. Use whenever an interaction needs feedback.
---
# Juice kit

Helpers live in `game/scripts/juice/` (autoload `Juice` once created):

- `Juice.popup(text, position, style)` — floating number/text.
- `Juice.squash(node, amount, time)` — press feedback.
- `Juice.shake(strength, time)` — camera or root shake, respects a "reduce motion" setting.
- `Juice.arc(from, to, sprite, count)` — items flying to a counter.
- `Juice.hitstop(ms)` and `Juice.haptic(kind)` (mobile vibration, respects settings).

The first feature that needs one creates it, with a unit test for timing/parameters. Never write one-off tweens for these effects elsewhere.
