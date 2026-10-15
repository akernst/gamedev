---
name: input-replay
description: Record and replay input sequences so bugs and playtests are reproducible. Use when filing a bug or building a bot playthrough.
---
# Input replay

Format: JSON lines in `game/tests/replays/<name>.jsonl`, one event per line: `{"frame": 120, "type": "tap", "x": 90, "y": 200}` (also `drag`, `key`, `wait`).

The first time this skill is needed, the gameplay programmer adds `game/tests/support/replay_player.gd`, a node that reads the file and calls `Input.parse_input_event` on the given frames, plus a test that replays a known file. After that, bugs are filed with a replay file and acceptance tests can drive the game through it.
