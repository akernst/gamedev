# gamedev

A reusable template for building games with a team of Claude Code agents. Every game starts as a copy of this repo; lessons learned in a game flow back here.

- **Process:** `docs/process/pipeline.md` — how a feature goes from an idea to a reviewed PR (kickoff interview → brief → spec → tests first → build → review gates → playtest).
- **Agents:** `.claude/agents/` — 18 specialists. The main Claude session is the 19th role, the orchestrator.
- **Skills:** `.claude/skills/` — 37 playbooks: process, engine adapters, content pipeline, quality.
- **Engine:** Godot (version in `GODOT_VERSION`). Only `tools/godot/` and the engine-adapter skills know that; see `docs/process/swapping-engines.md`.
- **House rules and commands:** `CLAUDE.md`.

## Start a new game from this template

1. On GitHub, mark this repo as a template (Settings → Template repository) and use "Use this template", or copy the files into an empty repo.
2. Fill in the **Project facts** and **Budgets** sections of `CLAUDE.md`, and `docs/design/vision.md`.
3. Set `game/project.godot` (name, display, renderer) and `game/export_presets.cfg` for the target platforms.
4. Run `tools/godot/test.sh` and `tools/godot/smoke.sh`, push, and check CI is green.
5. Describe the first feature. The orchestrator starts with `/kickoff`.

## Run locally

```bash
tools/godot/install.sh      # downloads the pinned Godot into .godot-bin/
tools/godot/test.sh         # headless tests
tools/godot/smoke.sh        # main scene for 600 frames, fails on errors
```

On macOS or Windows, install the same Godot version from godotengine.org to open `game/` in the editor; the scripts above target Linux and CI.
