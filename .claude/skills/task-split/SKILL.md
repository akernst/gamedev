---
name: task-split
description: Break a spec into tasks with owners, dependencies and parallel groups. Use inside /feature after the spec is written.
---
# Task split

Produce a table in the spec (or the task list) with: id, task, owner agent, depends on, acceptance criteria served, files touched.

Rules:
- One owner per task; one task touches one area (code, art, VFX, UI...).
- Tests (QA) and research come first; data/tuning before the code that reads it.
- Group tasks with no dependencies into waves that run in parallel.
- No two parallel tasks edit the same file. If they must, sequence them.
