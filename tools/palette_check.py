#!/usr/bin/env python3
"""Flags off-palette colours and semi-transparent pixels in pixel-art PNGs.

Usage: python3 tools/palette_check.py [--palette docs/design/palette.hex] img.png [...]
The palette file holds one hex colour per line (Lospec .hex format). Exit code 1 if anything is off.
"""
import argparse
import os
import sys
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from lib import png  # noqa: E402


def load_palette(path):
    colours = set()
    with open(path) as f:
        for line in f:
            line = line.strip().lstrip("#")
            if len(line) == 6:
                colours.add(tuple(int(line[i:i + 2], 16) for i in (0, 2, 4)))
    return colours


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--palette", default="docs/design/palette.hex")
    parser.add_argument("images", nargs="+")
    args = parser.parse_args()
    if not os.path.exists(args.palette):
        print(f"No palette file at {args.palette}; create it (one hex colour per line).")
        return 1
    palette = load_palette(args.palette)
    bad = False
    for path in args.images:
        _, _, rows = png.read(path)
        off, partial = Counter(), 0
        for row in rows:
            for r, g, b, a in row:
                if a == 0:
                    continue
                if a != 255:
                    partial += 1
                if (r, g, b) not in palette:
                    off["#%02x%02x%02x" % (r, g, b)] += 1
        if off or partial:
            bad = True
            print(f"{path}:")
            for colour, n in off.most_common(10):
                print(f"  off-palette {colour}: {n} px")
            if partial:
                print(f"  semi-transparent pixels: {partial}")
        else:
            print(f"{path}: ok")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
