---
name: scaffold
description: Create scenes, scripts and resources from the house templates (entity, UI screen, effect, data resource). Use when adding a new kind of thing to the game.
---
# Scaffold

Templates live in `game/templates/` (create the folder the first time a template is needed). Conventions:

- Script `game/scripts/<area>/<name>.gd` with `class_name`, typed vars, a doc comment.
- Logic class separate from the node: `<name>.gd` (RefCounted/Resource) plus `<name>_view.gd` (Node) when it has visuals.
- Data resource in `game/data/<area>/<name>.tres` with a matching `Resource` script.
- A unit test stub `game/tests/unit/test_<name>.gd` created at the same time.

After scaffolding, run `tools/godot/test.sh` to make sure the project still imports and tests pass.
