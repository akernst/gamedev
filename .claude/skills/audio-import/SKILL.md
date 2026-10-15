---
name: audio-import
description: Import audio with consistent loudness, loops and buses, and record licences. Use for every new sound or music file.
---
# Audio import

- Normalise: SFX peak around -6 dBFS, music around -16 LUFS integrated (use `ffmpeg -af loudnorm` if available).
- Short SFX as WAV, music as OGG with loop points set in the import settings.
- Bus: `SFX`, `Music` or `UI`. Players must use the right bus.
- Third-party audio: add a `assets/LICENSES.csv` row.
