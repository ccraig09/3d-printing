# [Project Name]

[One or two sentences: what physical problem does this solve?]

## Status

**Prototype / Fit validation / Production-ready:** [choose one]

A model is not “production-ready” simply because the STL is manifold or slices successfully.

## Evidence & assumptions

Classify important dimensions:

| Parameter | Value | Confidence | Source / reason |
| --- | ---: | --- | --- |
| `EXAMPLE_WIDTH` | 50.0 mm | INFERRED | Needs first physical fit test |

Use:

- **VERIFIED** — manufacturer/primary dimensional source
- **REFERENCE** — working community/reference model or teardown evidence
- **INFERRED** — engineering estimate awaiting physical test
- **PHYSICALLY VERIFIED** — tested on the real target and logged

## Hardware / BOM

| Item | Specification | Qty | Notes |
| --- | --- | ---: | --- |
| Fastener | TBD | 1 | Do not guess thread specs on valuable hardware |

## Current calibration question

> What is the smallest physical question this print needs to answer?

[Write it here before creating a large production print.]

## Print settings

| Parameter | Starting point |
| --- | --- |
| Printer | Original Prusa MK4S |
| Material | PETG / PLA / ASA |
| Layer height | 0.20 mm |
| Perimeters | 3–4 |
| Infill | 15–20% gyroid |
| Supports | Prefer none |

## Files

| File | Role |
| --- | --- |
| `model.scad` | Parametric CAD source |
| `fit-test.stl` | Current calibration export |
| `tests/fit-log.md` | Physical validation history |

Save slicer-specific `.3mf` projects from PrusaSlicer itself when exact printer/filament settings matter.

## Build / computational QC

Document the commands that build and inspect the model. Clearly state what those checks **do not** prove.

## Physical acceptance criteria

- [ ] [observable fit criterion]
- [ ] [clearance criterion]
- [ ] [alignment criterion]
- [ ] photos captured

Record the result in `tests/fit-log.md` before changing several dimensions at once.
