---
name: kickoff
description: Start every new feature here: interview the requester, gather references, play back an understanding, and produce a brief they confirm. Use whenever someone describes a new feature, mechanic or change to the game.
---
# Kickoff

Goal: a written brief, in the requester's own terms, that they confirm before any spec or code exists.

## Steps

1. **Play back.** In 2-4 sentences, restate what you think they want and list the assumptions you are making. Invite correction.
2. **Ask one round of 3-7 questions.** Each question carries your recommended answer so a one-word reply works. Pick from the areas below the ones the request leaves open; skip what is already clear.
   - *Fantasy and feel:* what should this feel like? Three adjectives.
   - *References:* games, videos or images that do something close; what to borrow, what to avoid.
   - *Controls and screens:* how the player triggers it, where it lives in the UI.
   - *Visuals and VFX:* what effects they picture, how intense, how often.
   - *Rules and numbers:* limits, costs, timers, interaction with existing systems.
   - *Scope:* must-have for v1, can-wait, out.
   - *Success:* how they will know it is right when they play it.
3. **Show** (visual features): ask the `art-director` and `vfx-artist` for a small reference board in `docs/design/refs/<slug>/` (links and notes, plus any CC0 images) so the requester can point instead of describe.
4. **Write the brief** to `docs/design/features/<slug>/brief.md` using the template below.
5. **Confirm.** Ask the requester to reply "yes" or correct it. If answers opened genuinely new questions, ask one more round. After two rounds, proceed on your recommended defaults and list them under *Assumed defaults*.

Do not start `/feature` until the brief is confirmed. Record the confirmation (date, who) at the top of the brief.

## Brief template

```markdown
# <Feature name>
Status: draft | confirmed <date> by <name>

## Goal
One paragraph in the requester's words.

## Feel
Three adjectives and what they mean here.

## References
- <link or file> — borrow: ..., avoid: ...

## Scope
- Must: ...
- Later: ...
- Out: ...

## Rules and numbers (known so far)
...

## Visuals, VFX and audio
...

## Success: how we will judge it in a playtest
- ...

## Assumed defaults
- ... (taken because the requester did not specify)

## Open risks
- ...
```
