#!/usr/bin/env python3
"""Checks that every asset file has a row in assets/LICENSES.csv with an allowed licence.

Usage: python3 tools/licence_audit.py
Columns: path,source_url,licence,author,notes   (path relative to the repo root)
"""
import csv
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASSET_DIRS = ["game/art", "game/audio", "game/fonts", "assets"]
ASSET_EXTS = {".png", ".jpg", ".jpeg", ".webp", ".svg", ".wav", ".ogg", ".mp3", ".ttf", ".otf", ".woff", ".woff2", ".aseprite", ".ase"}
ALLOWED = {"CC0", "CC-BY-4.0", "CC-BY-3.0", "OFL", "MIT", "original"}
LEDGER = os.path.join(ROOT, "assets", "LICENSES.csv")


def main():
    rows = {}
    with open(LEDGER, newline="") as f:
        for row in csv.DictReader(f):
            rows[row["path"].strip()] = row
    problems = []
    found = set()
    for d in ASSET_DIRS:
        for dirpath, _, files in os.walk(os.path.join(ROOT, d)):
            for name in files:
                if os.path.splitext(name)[1].lower() not in ASSET_EXTS:
                    continue
                rel = os.path.relpath(os.path.join(dirpath, name), ROOT)
                found.add(rel)
                if rel not in rows:
                    problems.append(f"missing licence row: {rel}")
    for path, row in rows.items():
        if path not in found:
            problems.append(f"row points to missing file: {path}")
        if row.get("licence", "").strip() not in ALLOWED:
            problems.append(f"licence not allowed for {path}: {row.get('licence')!r}")
    for p in problems:
        print(p)
    print(f"LICENCES: {len(found)} asset files, {len(problems)} problems")
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
