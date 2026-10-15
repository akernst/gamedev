# Feature pipeline

The requester appears three times: describing a feature, confirming the brief, and playtesting the build. Everything in between is the agents' job.

```
Requester describes a feature
        │
        ▼
/kickoff ── follow-up questions ──▶ requester (max two rounds)
        │
        ▼
Requester confirms brief.md
        │
        ▼
/feature: research (if new) → design → /spec → /task-split
        │
        ├──▶ qa-tester writes failing acceptance tests
        ├──▶ builders implement (code, art, VFX, animation, UI, audio, platform, shaders)
        └──▶ reviewers check (code-reviewer, art-director)
        │
        ▼
/review-gate on every hand-back ── fail ──▶ back to the owner (stop and ask after 3 rounds)
        │ pass
        ▼
Playtest analysis → PR with a playable build → requester playtests and approves
        │
        ▼
archivist: docs, changelog, retro (generic lessons → gamedev template)
```

## Roles

| Group | Agents |
| --- | --- |
| Direction and design | orchestrator (main session), game-designer, economy-designer, systems-researcher, art-director |
| Build | gameplay-programmer, platform-engineer, performance-optimizer, vfx-artist, technical-artist, art-asset-developer, animator, ui-ux-designer, audio-designer |
| Quality | qa-tester, code-reviewer, playtest-analyst |
| Operations | release-engineer, archivist |

A feature wakes only the agents its spec names.

## Where things live

| Artifact | Path | Owner |
| --- | --- | --- |
| Brief | `docs/design/features/<slug>/brief.md` | orchestrator |
| Spec | `docs/design/features/<slug>/spec.md` | orchestrator |
| GDD section | `docs/design/gdd.md` | game-designer |
| Economy | `docs/design/economy.md`, `game/data/economy/` | economy-designer |
| Research | `docs/research/<topic>.md` | systems-researcher |
| Acceptance tests | `game/tests/acceptance/` | qa-tester |
| Effects | `game/vfx/`, `docs/vfx/catalog.md` | vfx-artist |
| Decisions | `docs/decisions/` | anyone, via `/adr` |
| Retros | `docs/process/retros.md` | archivist |
