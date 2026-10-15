# Adding or changing an agent

1. Create `.claude/agents/<name>.md` with frontmatter: `name`, `description` (when the orchestrator should use it — this is how it gets picked), `tools`, `model`.
2. In the body: what it owns (files), what it must not do, how it works, and the hand-back format (copy from an existing agent).
3. Add it to the roles table in `docs/process/pipeline.md` and to `CLAUDE.md` if it owns a new directory.
4. If the change is generic, make it in the `gamedev` template too.

Keep the boundary rule: an agent that produces something never grades it.
