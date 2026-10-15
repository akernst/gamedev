---
name: asset-search
description: Find licence-clean art, audio or effect resources and record their origin and licence. Use before making an asset from scratch.
---
# Asset search

Order of preference: CC0, then CC-BY (needs attribution in credits), never non-commercial or unclear licences.

Good starting points: Kenney (kenney.nl, CC0), OpenGameArt (filter by CC0), itch.io free asset packs (check each licence), Freesound (filter CC0) for audio.

For every file you add, append to `assets/LICENSES.csv`: `path,source_url,licence,author,notes`. Store originals in `assets/source/`. Do not commit the whole pack, only what is used.
