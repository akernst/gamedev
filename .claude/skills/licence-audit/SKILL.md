---
name: licence-audit
description: Check every asset file against assets/LICENSES.csv. Use whenever assets change and in every review gate.
---
# Licence audit

```bash
python3 tools/licence_audit.py
```

Fails if any file under `game/art/`, `game/audio/`, `game/fonts/` or `assets/` (excluding `assets/source/` originals made in-house and listed as `original`) lacks a row, or a row points to a missing file, or a licence is not on the allowed list (`CC0`, `CC-BY-4.0`, `CC-BY-3.0`, `OFL`, `MIT`, `original`).
