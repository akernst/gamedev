---
name: sfx-generate
description: Generate retro sound effects from parameter presets and keep the preset with the sound. Use for coins, clicks, upgrades, alerts.
---
# SFX generate

- Generate with an sfxr-style generator. The first time, add `tools/sfx/sfxr.py` (pure Python, writes 16-bit WAV from a JSON preset of wave type, envelope, frequency slide, etc.).
- Presets: `assets/source/sfx/<name>.json`; output: `game/audio/sfx/<name>.wav`.
- Make 3-5 variants for frequent sounds (taps, coins) by jittering the preset.
- Then run `audio-import`.
