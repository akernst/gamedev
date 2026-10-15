---
name: export-build
description: Export playable builds for the configured presets. Use when a PR needs a build to try, or for releases.
---
# Export build

```bash
tools/godot/install.sh --templates      # once per machine/CI cache
tools/godot/export.sh "Android" build/game.apk
tools/godot/export.sh "Linux" build/game.x86_64
```

Presets live in `game/export_presets.cfg`. Android debug builds need Java 17 and the Android SDK (`ANDROID_HOME`); CI provides both and generates a debug keystore. Release signing keys are never committed. iOS exports require macOS with Xcode.
