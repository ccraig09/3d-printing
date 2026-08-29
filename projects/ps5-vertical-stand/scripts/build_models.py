#!/usr/bin/env python3
import subprocess
import sys
import os
import time
import shutil

OPENSCAD_BIN = shutil.which("openscad") or "/opt/homebrew/bin/openscad"

def build_stl(mode: str, output_path: str, scad_file: str = "ps5_stand.scad"):
    print(f"==================================================")
    print(f"Building: {output_path} (MODE='{mode}')")
    print(f"==================================================")
    
    cmd = [
        OPENSCAD_BIN,
        "-o", output_path,
        "-D", f"MODE=\"{mode}\"",
        scad_file
    ]
    
    t0 = time.time()
    result = subprocess.run(cmd, capture_output=True, text=True)
    dt = time.time() - t0
    
    if result.returncode != 0:
        print(f"ERROR compiling {output_path}:")
        print(result.stderr)
        sys.exit(1)
        
    if os.path.exists(output_path):
        size_kb = os.path.getsize(output_path) / 1024.0
        print(f"SUCCESS: Generated {output_path} ({size_kb:.1f} KB) in {dt:.2f}s")
    else:
        print(f"ERROR: Output file {output_path} was not created!")
        sys.exit(1)

def main():
    os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    
    targets = [
        ("FIT_TEST", "ps5-fat-fit-test.stl"),
        ("STAND", "ps5-fat-vertical-stand.stl"),
        ("ALT_STAND", "ps5-fat-vertical-stand-alt-fastener.stl"),
    ]
    
    for mode, out_file in targets:
        build_stl(mode, out_file)
        
    print("\nAll target STL files successfully built!")

if __name__ == "__main__":
    main()
