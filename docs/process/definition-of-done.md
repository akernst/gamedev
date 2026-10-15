# Definition of done

A task is done when the orchestrator's `/review-gate` passes. A feature is done when the requester approves the PR after playing the build.

1. **Tests green** — `tools/godot/test.sh` reports `RESULT: N passed, 0 failed`. New behaviour has tests. No test was weakened, skipped or deleted.
2. **Smoke clean** — `tools/godot/smoke.sh` passes (no errors or warnings over 600 frames).
3. **Visual check** — changed screens captured and looked at; goldens changed only on purpose, with a reason in the PR.
4. **Budgets held** — per the Budgets table in `CLAUDE.md`; numbers in the PR.
5. **Licences clean** — `python3 tools/licence_audit.py` passes.
6. **Docs current** — brief, spec and GDD match what was built.
7. **Requester playtest** — for anything player-facing.
