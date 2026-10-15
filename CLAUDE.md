# CLAUDE.md

Every agent reads this file first. It has two parts: **house rules** (generic, shared by every game built from the `gamedev` template) and **project facts** (this game only). Keep project facts in the last section so the template can be updated without touching them.

## How work flows

You describe a feature in plain words. The main session acts as the **orchestrator** and follows two skills in order:

1. `/kickoff` — interview the requester, gather references, play back an understanding, and write `docs/design/features/<slug>/brief.md`. **No spec or code before the requester confirms the brief.**
2. `/feature` — turn the confirmed brief into a spec with acceptance criteria, split it into tasks, delegate to the specialist subagents in `.claude/agents/`, review every hand-back with `/review-gate`, and open a PR with a playable build.

The orchestrator never writes game code or tests itself. Subagents cannot start other subagents, so all delegation goes through the orchestrator. See `docs/process/pipeline.md` for the full flow.

## House rules

- **The agent that writes something never grades it.** QA writes acceptance tests from the spec before code lands; builders make them pass; reviewers review. Only the orchestrator marks a task done.
- **Never weaken, skip or delete a test** to get green. Fix the code, or raise it with the orchestrator.
- **Nothing enters `assets/` without a row in `assets/LICENSES.csv`** (path, source URL, licence, author). CC0 first; anything else needs the orchestrator's sign-off.
- **Numbers designers tune live in data files** (`game/data/`), never as literals in scripts.
- **Engine-specific knowledge lives in adapter skills and `tools/godot/`.** Process skills and agent prompts stay engine-agnostic.
- **Decisions get an ADR** in `docs/decisions/` (use `/adr`).
- **Visual work is checked by looking:** any agent producing visuals renders a preview (`tools/godot/capture.sh`) and reads the PNG before handing back.
- **Small PRs.** One feature per PR; the requester approves every merge. Agents never merge.

## Commands

All commands run from the repo root. Godot is pinned in `GODOT_VERSION`.

| Task | Command |
| --- | --- |
| Install the pinned Godot (cached in `.godot-bin/`) | `tools/godot/install.sh` |
| Run all tests headless | `tools/godot/test.sh` (filter: `tools/godot/test.sh test_economy`) |
| Smoke run the main scene | `tools/godot/smoke.sh [frames]` |
| Capture frames of a scene to PNG | `tools/godot/capture.sh <res://scene.tscn> <out_dir> [frames]` |
| Capture a scene at phone sizes | `tools/godot/screens.sh <res://scene.tscn> <out_dir> [WxH,...]` |
| Performance capture | `tools/godot/perf.sh <res://scene.tscn> [frames]` |
| Export a build | `tools/godot/export.sh <preset> <out_file>` |
| Licence audit | `python3 tools/licence_audit.py` |
| Compare screenshots to goldens | `python3 tools/screenshot_compare.py <actual_dir> <golden_dir>` |
| Palette check | `python3 tools/palette_check.py <png...>` |

A hook in `.claude/settings.json` parses every `.gd` file under `game/` right after it is edited and reports parse errors immediately.

## Layout

- `game/` — the Godot project (`project.godot`). Tests live in `game/tests/` (Godot can only load files inside the project). Data in `game/data/`.
- `assets/source/` — editable sources (`.aseprite`, sound presets). Exported files go under `game/`.
- `docs/design/` — `vision.md`, `gdd.md`, `style-guide.md`, `features/<slug>/{brief,spec}.md`.
- `docs/decisions/`, `docs/research/`, `docs/vfx/catalog.md`, `docs/qa/`, `docs/playtests/`, `docs/perf/` — outputs of the matching agents.
- `docs/process/` — the generic process. Changes here should also go to the `gamedev` template.

## Quality gates (definition of done)

A task is done only when all pass; see `docs/process/definition-of-done.md`.

1. Tests green (`tools/godot/test.sh`).
2. Smoke run clean: main scene runs the configured frames with no errors or warnings.
3. Visual check: changed screens captured and attached to the PR; goldens updated only on purpose.
4. Budgets held: see **Budgets** below.
5. Requester playtest for anything player-facing.

## Testing conventions

- A test file is `game/tests/**/test_*.gd`, `extends "res://tests/test_case.gd"`, with methods named `test_*`.
- Assertions: `assert_true`, `assert_false`, `assert_eq`, `assert_ne`, `assert_almost_eq`, `assert_null`, `assert_not_null`. Each failure prints the test file, test name and message; engine errors raised during a test (with file:line) also fail it.
- Keep logic in plain scripts (`RefCounted` / `Resource`) so it is testable without scenes; scenes wire it up.

---

## Project facts (edit per game)

- **Game:** _name and one-line pitch_
- **Genre / platform:** _e.g. idle, mobile portrait_
- **Look:** _see `docs/design/style-guide.md`_
- **Requester:** _who approves briefs and PRs_

### Budgets

| Budget | Limit |
| --- | --- |
| Frame time | 16.6 ms (60 fps) on the reference device |
| Memory | _set per game_ |
| Build size | _set per game_ |
| Live particles on the busiest screen | _set per game_ |
