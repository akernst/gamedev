---
name: spec
description: Turn a confirmed brief into a spec with numbered, testable acceptance criteria, named agents and open questions. Use inside /feature.
---
# Spec

Write `docs/design/features/<slug>/spec.md`:

```markdown
# <Feature> spec
Brief: ./brief.md

## Acceptance criteria
AC1. When <situation>, <observable result> (measurable: number, time, state).
AC2. ...

## Out of scope
...

## Agents and ownership
| Task | Agent | Files |

## Data and tuning
Which values live in `game/data/` and who owns them.

## Test plan
Which ACs are unit, acceptance, visual (capture/golden), perf, or playtest-only.

## Open questions
Each with a recommended default.
```

Rules: every criterion must be checkable by a test, a capture, a number or a named playtest question. Words like "fun" or "smooth" belong in the brief, translated here into something observable (e.g. "coin burst plays within 1 frame of the tap and lasts 0.3-0.5 s").
