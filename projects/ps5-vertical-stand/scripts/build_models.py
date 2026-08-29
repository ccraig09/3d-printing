#!/usr/bin/env python3
"""Build the PS5 V3 fit gauge and V4 production stand candidates."""
import os
import shutil
import subprocess
import sys

OPENSCAD_BIN = shutil.which("openscad") or "/opt/homebrew/bin/openscad"
TARGETS = [
    ("FIT_TEST", "ps5-fat-fit-test-v3.stl"),
    ("OEM_STAND", "ps5-fat-vertical-stand-oem.stl"),
    ("REPLACEMENT_STAND", "ps5-fat-vertical-stand-replacement.stl"),
]


def build(mode: str, output: str) -> None:
    cmd = [OPENSCAD_BIN, "-o", output, "-D", f'MODE="{mode}"', "ps5_stand.scad"]
    result = subprocess.run(cmd, text=True, capture_output=True)
    if result.returncode != 0:
        print(result.stdout)
        print(result.stderr, file=sys.stderr)
        raise SystemExit(result.returncode)
    if not os.path.exists(output):
        raise SystemExit(f"OpenSCAD returned success but did not create {output}")
    print(f"Built {output} ({os.path.getsize(output)} bytes)")


def main():
    project_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    os.chdir(project_dir)
    for mode, output in TARGETS:
        build(mode, output)


if __name__ == "__main__":
    main()
