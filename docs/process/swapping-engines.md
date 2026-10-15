# Swapping engines

Engine knowledge is confined to:

- `GODOT_VERSION` and `tools/godot/` (install, test, smoke, capture, perf, export),
- `game/` (the project itself, including `game/tests/runner.gd` and `test_case.gd`),
- the engine-adapter skills: `engine-setup`, `scaffold`, `run-tests`, `run-game`, `input-replay`, `perf-capture`, `shader-check`, `export-build`,
- the Commands, Layout and Testing sections of `CLAUDE.md`.

To use another engine, reimplement those with the same command names and output contracts (`RESULT: N passed, M failed`, `SMOKE: OK`, PNG frames, a JSON perf summary). Agents, process skills, quality gates and docs stay as they are.

| Engine | Tests | Headless/smoke | Captures |
| --- | --- | --- | --- |
| Unity | `-batchmode -runTests` (Unity Test Framework) | `-batchmode -nographics -executeMethod` | `ScreenCapture` in a play-mode test |
| Bevy | `cargo test` | run with a headless plugin set for N frames | render to texture, save PNG |
| Web (Phaser) | Vitest/Jest | Playwright headless | Playwright screenshots |
