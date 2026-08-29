# Original / Fat PlayStation 5 Disc Edition Vertical Stand

Recovery project for a 3D-printable vertical stand for the **original / fat PlayStation 5 Disc Edition (CFI-1000 family)**.

> **Current status: 🧪 Physical fit validation / Recovery V3**  
> The prior V1/V2 cradle geometry failed physical fit or was never physically validated. The project is intentionally back at the calibration stage. **There is no production-ready stand STL in V3 yet.**

## Why V3 exists

The earlier design made a classic CAD mistake: it converted uncertain underside geometry into precise-looking dimensions, then used mesh checks as if they proved console compatibility. A watertight STL can still be the wrong shape.

Recovery V3 changes the contract:

```text
research / evidence
      ↓
small calibration interface
      ↓
physical fit test on the real PS5
      ↓
record evidence
      ↓
only then design the production stand
```

## Current printable artifact

| File | Status | Purpose |
| --- | --- | --- |
| `ps5-fat-fit-test-v3.stl` | **PRINT THIS NEXT** | Small PETG mounting-interface gauge around the factory stand screw axis |
| `ps5_stand.scad` | Source of truth | Parametric OpenSCAD source for the V3 gauge |
| `scripts/build_models.py` | Active | Builds the V3 STL with OpenSCAD |
| `scripts/verify_mesh.py` | Active | Checks mesh integrity and CAD intent only |
| `tests/fit-log.md` | Active | Physical source of truth for prototype results |

The old V1/V2/V2.1 STL and generated 3MF artifacts are intentionally removed from the active tree. Git history preserves them if they are ever needed for forensic comparison.

## V3 calibration geometry

V3 deliberately **does not attempt to wrap the PS5 underside**.

It uses:

- 48 mm diameter calibration disk
- 5 mm center sight / clearance bore
- three 8 mm contact pads on a 30 mm pitch circle
- 0.8 mm contact-pad height
- three inspection windows

The three contact pads form a tripod. That gives us a simple physical question: **does the local black mounting region around the factory screw point support three contacts without rocking or colliding with nearby plastic?**

Every V3 dimension above is **INFERRED** and exists to create a cheap experiment, not to claim Sony geometry.

## Evidence classification

Use these words consistently:

- **VERIFIED** — directly supported by a manufacturer or primary dimensional source.
- **REFERENCE** — supported by a working/community design or teardown observation, but not a formal Sony dimension.
- **INFERRED** — engineering estimate that must be physically tested.
- **PHYSICALLY VERIFIED** — tested on the actual target console and recorded in `tests/fit-log.md`.

Known high-confidence references for this project include the original PS5 overall dimensions, Sony's use of the factory stand mounting point, and the original stand screw's approximately 26.5 mm total length. The exact underside mating contour is **not** treated as verified.

## Print the V3 fit test

Use **PETG**. For the calibration coupon, durability matters more than cosmetics, but it is a low-load test piece.

Recommended starting point on the Prusa MK4S:

- 0.20 mm layer height
- 3–4 perimeters
- 4 top / 4 bottom layers
- 15–20% gyroid infill
- no supports
- print flat

Use PrusaSlicer directly. Save a native `.3mf` from PrusaSlicer only if you want to preserve your exact slicer profile. This repository no longer fabricates pseudo-Prusa 3MF projects in Python.

## Physical test procedure

1. Power off and unplug the PS5.
2. Remove the factory stand screw-hole cap if present.
3. **Do not force a screw into the console.** The V3 coupon can be tested by hand first.
4. Place the three raised contact pads against the black structural area around the mounting point.
5. Center the printed sight bore over the factory mounting insert.
6. Check the acceptance list in `tests/fit-log.md`.
7. Take clear front/rear/side photos before changing CAD.

### Pass means

- no white-panel or vent collision
- all three contact pads touch
- no obvious rocking while lightly held
- center sight bore can align with the factory mounting point

A V3 pass does **not** mean the final stand is done. It means we have earned the right to design the next interface layer.

## Build and verify

From this project directory:

```bash
python scripts/build_models.py
python scripts/verify_mesh.py
```

`verify_mesh.py` proves only:

- STL is watertight
- triangle winding is consistent
- expected V3 bounding dimensions are present
- the center bore is geometrically open

It explicitly does **not** claim physical PS5 fit.

## Production stand gate

A production stand should not be generated until the V3 physical checklist is recorded as passing or the failure evidence gives us the next measured correction.

When that gate is crossed, the production stand can reintroduce:

- ~155–165 mm stability footprint
- structural fastener seat
- anti-rotation features
- rubber-foot recesses
- airflow clearance

Those features will be built around **physically established interface geometry**, not guessed full-console contours.
