---
name: review-gate
description: Checklist the orchestrator runs on every hand-back before accepting it. Use whenever a subagent returns work.
---
# Review gate

Check each item and record pass/fail with evidence. Any fail goes back to the owner with the exact failure and the criterion it blocks.

1. **Criteria:** every acceptance criterion the task claims is met, with evidence (test name, capture path, number).
2. **Tests:** `tools/godot/test.sh` passes; new behaviour has tests; no test was weakened, skipped or deleted (`git diff` on `game/tests/`).
3. **Smoke:** `tools/godot/smoke.sh` is clean.
4. **Ownership:** the agent only touched files its task owns.
5. **Data:** no designer numbers hard-coded in scripts.
6. **Assets:** `python3 tools/licence_audit.py` passes.
7. **Budgets:** perf numbers within `CLAUDE.md` budgets when the change could affect them.
8. **Visuals:** captures exist and were looked at; the art director's verdict is on-style for visual changes.
9. **Docs:** spec/brief updated if behaviour differs from what was planned.
