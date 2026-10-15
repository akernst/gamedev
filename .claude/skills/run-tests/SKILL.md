---
name: run-tests
description: Run the headless test suite and report results. Use after any code change and in every review.
---
# Run tests

```bash
tools/godot/test.sh            # all tests
tools/godot/test.sh economy    # only test files whose path contains "economy"
```

The runner (`game/tests/runner.gd`) finds `game/tests/**/test_*.gd`, runs every `test_*` method, prints one line per failure (file, test name, message); engine errors during a test, with their file:line, fail that test, and ends with `RESULT: <passed> passed, <failed> failed`. Exit code is non-zero on any failure or script error.

Report the RESULT line in hand-backs.
