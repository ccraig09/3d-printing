# Original / Fat PlayStation 5 Disc Edition Vertical Stand

Parametric PETG stand project for the **original / fat PS5 Disc Edition (CFI-1000 family)**.

> **Current status: 🛠️ V4 Production Candidate — physical stand validation pending**  
> The V3 local mounting-interface gauge physically passed on the real console on 2026-08-29: flat, no wobble, good seating. V4 reuses that exact contact geometry and expands it into a full 160 mm stand.

## Why this version is different

Earlier versions guessed a broad PS5 underside contour. V4 does not. It keeps the only geometry we have physically proven: the center mounting axis and the three V3 contact pads.

```text
V3 physical PASS
      ↓
freeze proven contact geometry
      ↓
add 160 mm structural base
      ↓
parameterized fastener seat
      ↓
V4 production candidate
      ↓
final physical stand test
```

## Active files

| File | Purpose |
| --- | --- |
| `ps5_stand.scad` | Parametric source of truth for V3 gauge + V4 stands |
| `scripts/build_models.py` | Builds V3 gauge and both V4 STL candidates |
| `scripts/verify_mesh.py` | Verifies mesh/CAD properties only |
| `tests/fit-log.md` | Physical source of truth |
| `tests/production-stand-contract.md` | V4 requirements written before implementation |

## V4 geometry

Shared body:

- 160 mm base diameter
- 10 mm base thickness
- small printable edge chamfer
- exact V3 contact pattern: three 8 mm pads on a 30 mm pitch circle, 0.8 mm high
- 5 mm center clearance bore
- four optional 11 mm × 1 mm rubber-foot recesses
- no guessed enclosing cradle walls

The original Sony stand footprint is used only as a reference for scale; the production candidate is intentionally 5 mm larger.

## Fastener strategy

### OEM variant

`ps5-fat-vertical-stand-oem.stl`

Designed around the original captive PS5 stand-screw style. iFixit verifies the original stand screw is **26.5 mm overall length**. This project does **not** claim a verified thread diameter or pitch.

### Replacement variant

`ps5-fat-vertical-stand-replacement.stl`

Designed for a purpose-made captive replacement sold for original PS5 CFI-1000/1100/1200 stands. ZedLabz describes its replacement as matching the original Sony captive screw, but does not publish enough dimensional data to justify a different printed seat.

Therefore the OEM and replacement candidates currently share the same conservative 5 mm through-bore and 16 mm × 4 mm underside counterbore. The parameters are separate in CAD so they can diverge after the actual replacement screw is measured.

**Do not substitute a random M3/M4 screw into the console based only on internet claims.**

## Build and verify

```bash
python scripts/build_models.py
python scripts/verify_mesh.py
```

Expected outputs:

- `ps5-fat-fit-test-v3.stl`
- `ps5-fat-vertical-stand-oem.stl`
- `ps5-fat-vertical-stand-replacement.stl`

Computational checks verify watertightness, winding, expected dimensions, an open center bore, and that the two fastener variants preserve the same external stand body. They do not prove final PS5 fit.

## Recommended Prusa MK4S starting settings

For the full V4 stand:

- PETG
- 0.20 mm layer height
- 4 perimeters
- 5 top / 5 bottom layers
- 20% gyroid infill
- no supports
- print flat on the base

## Physical validation gate

V3 has passed. V4 has not yet been physically proven as a complete stand.

Before marking this project Production Verified, check `tests/fit-log.md` and confirm:

- console stands without rocking
- all three V3-derived pads remain seated
- no white-panel or vent interference
- the chosen PS5-compatible fastener engages smoothly and clamps correctly

## Evidence language

- **VERIFIED** — manufacturer/primary dimensional evidence
- **REFERENCE** — credible teardown/community/vendor evidence
- **INFERRED** — engineering estimate
- **PHYSICALLY VERIFIED** — tested on the actual target console and recorded in the fit log

Generated STL files are build outputs. The committed OpenSCAD file remains the design source of truth. Save `.3mf` projects from PrusaSlicer itself when exact printer/filament settings matter.
