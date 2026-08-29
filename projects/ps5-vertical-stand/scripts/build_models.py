#!/usr/bin/env python3
"""Build only the Recovery V3 calibration artifact.

A production stand is intentionally not generated until physical fit evidence exists.
"""
import os
import shutil
import subprocess
import sys

OPENSCAD_BIN = shutil.which("openscad") or "/opt/homebrew/bin/openscad"


def main():
    project_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    os.chdir(project_dir)
    output = "ps5-fat-fit-test-v3.stl"
    cmd = [OPENSCAD_BIN, "-o", output, "-D", 'MODE="FIT_TEST"', "ps5_stand.scad"]
    result = subprocess.run(cmd, text=True, capture_output=True)
    if result.returncode != 0:
        print(result.stdout)
        print(result.stderr, file=sys.stderr)
        raise SystemExit(result.returncode)
    if not os.path.exists(output):
        raise SystemExit(f"OpenSCAD returned success but did not create {output}")
    print(f"Built {output} ({os.path.getsize(output)} bytes)")


if __name__ == "__main__":
    main()
