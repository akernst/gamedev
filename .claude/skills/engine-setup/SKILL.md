---
name: engine-setup
description: Install and verify the pinned Godot version locally or in CI, including export templates when building. Use before any engine command if Godot is missing, or when upgrading the engine.
---
# Engine setup (Godot)

- Version pin: `GODOT_VERSION` at the repo root.
- Install: `tools/godot/install.sh` downloads the official Linux build into `.godot-bin/<version>/` and prints the binary path. `tools/godot/install.sh --templates` also installs export templates (large download; needed only for `export.sh`).
- All other scripts call `tools/godot/godot.sh`, which installs on first use and runs the pinned binary.
- First import of the project: `tools/godot/godot.sh --headless --path game --import` (scripts do this automatically).

Upgrading: change `GODOT_VERSION`, run tests, smoke and a capture, record an ADR.

On macOS or Windows, the requester installs the same version from godotengine.org; agents in the cloud use the Linux build.
