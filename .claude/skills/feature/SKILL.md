---
name: feature
description: The orchestrator's main playbook for building a confirmed brief into a reviewed PR. Use after /kickoff has a confirmed brief.
---
# Feature

Preconditions: `docs/design/features/<slug>/brief.md` exists and is confirmed. If not, run `/kickoff` first.

## Steps

1. **Branch:** `feature/<slug>` from the default branch.
2. **Research (optional):** if the mechanic is new to the team, delegate a brief to `systems-researcher`.
3. **Design:** delegate rules to `game-designer`; numbers and pacing to `economy-designer` when progression is touched.
4. **Spec:** run `/spec` to write `spec.md` with numbered, testable acceptance criteria and the agents involved.
5. **Tasks:** run `/task-split`. Start tasks that do not depend on each other in parallel (several Agent calls in one message).
6. **Tests first:** delegate acceptance tests to `qa-tester`; confirm they fail for the right reason.
7. **Build:** delegate to builders (programmer, art, VFX, animation, UI, audio, platform, technical art) with: the spec path, their task, the criteria they serve, and files they own.
8. **Review each hand-back** with `/review-gate`. Failing items go back to the owner with the exact failure. After three failed rounds on one task, stop and ask the requester, with what was tried.
9. **Polish pass:** `playtest-analyst` report; `art-director` verdict on captures; `code-reviewer` on the full diff.
10. **PR:** open it with the template below. Attach captures and the build artifact link. The requester approves; agents never merge.
11. **Close out:** `archivist` updates docs, changelog and retro.

## PR description template

```markdown
## What you can try
<one paragraph: what to tap/see in the build>

## Acceptance criteria
- [x] AC1 ... (evidence: test name / capture)

## Screens
<captures>

## Budgets
<perf numbers vs CLAUDE.md>

## Known gaps
...
```
