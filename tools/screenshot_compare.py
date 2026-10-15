#!/usr/bin/env python3
"""Compares PNGs in an actual directory with goldens of the same name.

Usage: python3 tools/screenshot_compare.py <actual_dir> <golden_dir> [--threshold 0.001] [--update]
Writes <name>.diff.png next to each differing actual (red = changed pixels). Exit 1 on any difference
above the threshold (fraction of pixels), a missing golden, or a size mismatch.
"""
import argparse
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from lib import png  # noqa: E402


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("actual")
    parser.add_argument("golden")
    parser.add_argument("--threshold", type=float, default=0.001)
    parser.add_argument("--update", action="store_true", help="copy actuals over goldens")
    args = parser.parse_args()
    names = sorted(n for n in os.listdir(args.actual) if n.endswith(".png") and not n.endswith(".diff.png"))
    if args.update:
        os.makedirs(args.golden, exist_ok=True)
        for n in names:
            shutil.copy(os.path.join(args.actual, n), os.path.join(args.golden, n))
        print(f"Updated {len(names)} goldens in {args.golden}")
        return 0
    failed = False
    for n in names:
        gpath = os.path.join(args.golden, n)
        if not os.path.exists(gpath):
            print(f"{n}: no golden")
            failed = True
            continue
        aw, ah, arows = png.read(os.path.join(args.actual, n))
        gw, gh, grows = png.read(gpath)
        if (aw, ah) != (gw, gh):
            print(f"{n}: size {aw}x{ah} != golden {gw}x{gh}")
            failed = True
            continue
        diff_rows, changed = [], 0
        for ar, gr in zip(arows, grows):
            row = []
            for ap, gp in zip(ar, gr):
                if ap != gp:
                    changed += 1
                    row.append((255, 0, 0, 255))
                else:
                    row.append((ap[0] // 3, ap[1] // 3, ap[2] // 3, 255))
            diff_rows.append(row)
        fraction = changed / float(aw * ah)
        status = "ok" if fraction <= args.threshold else "DIFFERS"
        print(f"{n}: {fraction:.5f} of pixels changed ({status})")
        if fraction > args.threshold:
            failed = True
            png.write(os.path.join(args.actual, n[:-4] + ".diff.png"), aw, ah, diff_rows)
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
