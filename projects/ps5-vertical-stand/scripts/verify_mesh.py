#!/usr/bin/env python3
"""Recovery V3 computational checks.

These checks verify mesh integrity and internal CAD intent only.
They DO NOT claim that the model physically fits a PS5.
"""
import os
import numpy as np
import trimesh

EXPECTED_EXTENTS = np.array([48.0, 48.0, 4.8])
EXTENT_TOLERANCE_MM = 0.08


def verify(path: str) -> bool:
    mesh = trimesh.load(path, force="mesh")
    ok = True

    print(f"File: {path}")
    print(f"Watertight: {mesh.is_watertight}")
    print(f"Winding consistent: {mesh.is_winding_consistent}")
    print(f"Extents: {mesh.extents}")

    if not mesh.is_watertight:
        print("FAIL: mesh is not watertight")
        ok = False
    if not mesh.is_winding_consistent:
        print("FAIL: mesh winding is inconsistent")
        ok = False
    if not np.allclose(mesh.extents, EXPECTED_EXTENTS, atol=EXTENT_TOLERANCE_MM):
        print(f"FAIL: unexpected extents; expected {EXPECTED_EXTENTS} ± {EXTENT_TOLERANCE_MM} mm")
        ok = False

    # Center bore check without optional spatial-index dependencies.
    # Cast one mathematical ray along +Z through X=Y=0 and check whether
    # it intersects any mesh triangle. A true through-bore has zero hits.
    triangles = mesh.triangles
    origin = np.array([0.0, 0.0, mesh.bounds[0, 2] - 1.0])
    direction = np.array([0.0, 0.0, 1.0])
    eps = 1e-9
    hits = 0
    for tri in triangles:
        v0, v1, v2 = tri
        edge1 = v1 - v0
        edge2 = v2 - v0
        h = np.cross(direction, edge2)
        a = float(np.dot(edge1, h))
        if -eps < a < eps:
            continue
        f = 1.0 / a
        svec = origin - v0
        u = f * float(np.dot(svec, h))
        if u < 0.0 or u > 1.0:
            continue
        q = np.cross(svec, edge1)
        v = f * float(np.dot(direction, q))
        if v < 0.0 or u + v > 1.0:
            continue
        t = f * float(np.dot(edge2, q))
        if t > eps:
            hits += 1

    bore_open = hits == 0
    print(f"Center bore open: {bore_open} (axis/triangle intersections={hits})")
    if not bore_open:
        print("FAIL: center bore is obstructed")
        ok = False

    print("NOTE: Physical PS5 fit remains UNVERIFIED until the printed V3 coupon is tested on the console.")
    return ok


if __name__ == "__main__":
    project_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    os.chdir(project_dir)
    success = verify("ps5-fat-fit-test-v3.stl")
    raise SystemExit(0 if success else 1)
