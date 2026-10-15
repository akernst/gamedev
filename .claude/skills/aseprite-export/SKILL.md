---
name: aseprite-export
description: Export sprite sheets and animation tags from .aseprite sources via the command line. Use when art is authored in Aseprite.
---
# Aseprite export

```bash
aseprite -b assets/source/<name>.aseprite --sheet game/art/<name>.png --data game/art/<name>.json --format json-array --list-tags --sheet-type packed
```

Aseprite is a paid tool on the requester's machine; in cloud sessions it may be missing. In that case export from LibreSprite (free fork, same CLI flags) if installed, or ask the requester to export. Never commit only the PNG when a source exists.
