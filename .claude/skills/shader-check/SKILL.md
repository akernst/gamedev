---
name: shader-check
description: Compile every shader for the target renderer and fail on errors. Use after any shader change.
---
# Shader check

Shaders compile when a scene using them renders. Run `tools/godot/capture.sh` on the scene that uses the shader (or `game/tests/visual/shader_gallery.tscn`, created the first time it is needed, which instantiates every material) and check the output for `SHADER ERROR`. Mobile games target the Compatibility renderer: test with `--rendering-driver opengl3`.
