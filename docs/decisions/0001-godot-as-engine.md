# 0001. Godot as the default engine

Date: 2026-10-04. Status: accepted.

## Context
Agents need a project they can read, diff and edit as text, and an engine that runs tests and the game without a display so CI and cloud sessions can verify work.

## Decision
Use Godot 4 (version pinned in `GODOT_VERSION`), GDScript first. Engine-specific knowledge stays in `tools/godot/` and the adapter skills.

## Consequences
Scenes, resources and scripts are text. Tests and smoke runs are headless. Free, no account. Switching engines means reimplementing the adapter layer only (`docs/process/swapping-engines.md`).

## Alternatives considered
Unity (heavier, licence/account, noisier scene files), Unreal (binary assets, very large), Bevy (no editor), web frameworks (weaker for native mobile).
