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

Presets live in `game/export_presets.cfg`. Android builds need Java 17+ and an Android SDK with `platform-tools` and `build-tools`. Godot looks for the SDK at `~/Android/Sdk` by default (CI symlinks `$ANDROID_HOME` there) and creates a debug keystore with `keytool` on first export. Release signing keys are never committed; they come from CI secrets. iOS exports require macOS with Xcode.

In cloud sessions the Android SDK host may be blocked by the network policy, so Android APKs are built by CI and downloaded from the workflow run's artifacts.
