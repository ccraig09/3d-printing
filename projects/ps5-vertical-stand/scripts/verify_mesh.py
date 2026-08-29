#!/usr/bin/env python3
"""Computational checks for V3/V4 PS5 stand meshes.

These checks prove mesh/CAD properties only. Physical PS5 compatibility is recorded
separately in tests/fit-log.md.
"""
import os
import numpy as np
import trimesh

TARGETS = {
    "ps5-fat-fit-test-v3.stl": np.array([48.0, 48.0, 4.8]),
    "ps5-fat-vertical-stand-oem.stl": np.array([160.0, 160.0, 10.8]),
    "ps5-fat-vertical-stand-replacement.stl": np.array([160.0, 160.0, 10.8]),
}
TOLERANCE_MM = 0.15


def origin_in_xy_triangle(t) -> bool:
    a, b, c = t
    v0 = c - a
    v1 = b - a
    v2 = -a
    den = v0[0] * v1[1] - v1[0] * v0[1]
    if abs(den) < 1e-12:
        return False
    u = (v2[0] * v1[1] - v1[0] * v2[1]) / den
    v = (v0[0] * v2[1] - v2[0] * v0[1]) / den
    return u >= -1e-9 and v >= -1e-9 and (u + v) <= 1 + 1e-9


def verify(path: str, expected: np.ndarray) -> trimesh.Trimesh:
    mesh = trimesh.load_mesh(path, process=True)
    print(f"\nFile: {path}")
    print(f"Watertight: {mesh.is_watertight}")
    print(f"Winding consistent: {mesh.is_winding_consistent}")
    print(f"Extents: {mesh.extents}")

    assert mesh.is_watertight, "mesh is not watertight"
    assert mesh.is_winding_consistent, "mesh winding is inconsistent"
    assert np.allclose(mesh.extents, expected, atol=TOLERANCE_MM), (
        f"unexpected extents; expected {expected} ± {TOLERANCE_MM} mm"
    )

    blockers = sum(origin_in_xy_triangle(t[:, :2]) for t in mesh.triangles)
    print(f"Center bore projected blockers: {blockers}")
    assert blockers == 0, "center mounting bore is obstructed"
    return mesh


def main() -> None:
    project_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    os.chdir(project_dir)
    meshes = {name: verify(name, extents) for name, extents in TARGETS.items()}

    oem = meshes["ps5-fat-vertical-stand-oem.stl"]
    replacement = meshes["ps5-fat-vertical-stand-replacement.stl"]
    assert np.allclose(oem.bounds, replacement.bounds, atol=1e-6), (
        "fastener variants changed the shared external body geometry"
    )

    print("\nPASS: computational V3/V4 mesh contract")
    print("NOTE: final production stand fit is still a physical validation gate.")


if __name__ == "__main__":
    main()
