---
name: review-code
description: Code review checklist for the code-reviewer agent. Use on every diff that changes scripts or scenes.
---
# Review code

Check, citing `file:line`:

1. **Correctness:** does it do what the spec says, including edge cases (zero, max, offline, interrupted)?
2. **Tests:** new behaviour covered; tests assert outcomes, not implementation details; nothing weakened.
3. **Architecture:** logic separate from nodes; tuning from data; signals not polling; no new globals.
4. **Readability:** names, small functions, typed GDScript, comments where intent is not obvious.
5. **Performance:** allocations or heavy work per frame, many `_process` callbacks, unbounded growth.
6. **Rules:** anything in `CLAUDE.md` house rules.

Output: **Approve** or **Required changes** (numbered), then **Optional** suggestions.
