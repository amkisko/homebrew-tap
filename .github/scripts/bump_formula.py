#!/usr/bin/env python3
"""Update a Homebrew formula url tag and sha256. Idempotent when already current."""

from __future__ import annotations

import argparse
import pathlib
import re
import sys


def bump(formula_path: pathlib.Path, repository: str, tag: str, sha256: str) -> bool:
    text = formula_path.read_text(encoding="utf-8")
    archive_url = f"https://github.com/{repository}/archive/refs/tags/{tag}.tar.gz"
    updated = text
    updated = re.sub(
        r'url "https://github\.com/[^"]+/archive/refs/tags/[^"]+\.tar\.gz"',
        f'url "{archive_url}"',
        updated,
        count=1,
    )
    updated = re.sub(
        r'sha256 "[0-9a-fA-F]{0,64}"',
        f'sha256 "{sha256}"',
        updated,
        count=1,
    )
    if updated == text:
        already = archive_url in text and f'sha256 "{sha256}"' in text
        if already:
            return False
        raise SystemExit(
            f"failed to update {formula_path}: url/sha256 patterns not found"
        )
    formula_path.write_text(updated, encoding="utf-8")
    return True


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("formula_path", type=pathlib.Path)
    parser.add_argument("--repository", required=True)
    parser.add_argument("--tag", required=True)
    parser.add_argument("--sha256", required=True)
    args = parser.parse_args()
    if not re.fullmatch(r"v?\d+\.\d+\.\d+([.-].+)?", args.tag):
        print(f"refusing unexpected tag shape: {args.tag}", file=sys.stderr)
        return 2
    if not re.fullmatch(r"[0-9a-fA-F]{64}", args.sha256):
        print("sha256 must be 64 hex chars", file=sys.stderr)
        return 2
    if not args.formula_path.is_file():
        print(f"missing formula: {args.formula_path}", file=sys.stderr)
        return 2
    changed = bump(args.formula_path, args.repository, args.tag, args.sha256)
    print("changed" if changed else "unchanged")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
