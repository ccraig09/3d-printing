# PS5 Vertical Stand — Physical Fit Log

This file is the physical source of truth. Computational mesh checks are useful, but they cannot prove that a printed part fits the console.

## Console

- Target: Original / Fat PlayStation 5 Disc Edition, CFI-1000 family
- User-confirmed hardware: original/fat Disc Edition

## Prototype history

### V1 — FAIL

- Result: **Failed physical fit**
- Evidence: user photos from 2026-08-28
- Observed failure: the coupon/cradle geometry collided with or could not seat around the real console underside.
- Root cause: CAD attempted to model a broad underside contour from dimensions that were not actually established from a verified dimensional drawing or physical measurement.

### V2 / V2.1 — NOT ACCEPTED AS VALIDATED

- Result: **Not production-verified**
- The source used inferred chassis geometry such as a nominal 50 mm × 98 mm locating region and 1.2 mm clearance.
- Prior automated QC established mesh validity, not physical compatibility.
- Do not treat prior STL/3MF artifacts as production-ready.

### V3 — CURRENT FRONTIER

- Artifact generated from source: `ps5-fat-fit-test-v3.stl`
- Purpose: test only the local mounting interface around the factory stand screw axis.
- Geometry strategy: 48 mm calibration disk with a center sight bore and three 0.8 mm raised contact pads.
- No production stand is generated yet.

#### V3 physical acceptance checklist

Print in PETG, power off and unplug the PS5, then hold the coupon against the mounting area without forcing it.

- [ ] Center bore can be visually centered over the factory stand mounting insert.
- [ ] None of the 48 mm outer disk touches a white side panel or vent feature.
- [ ] All three raised contact pads touch the black structural surface at the same time.
- [ ] Coupon does not visibly rock when lightly held in position.
- [ ] Inspection windows show no hidden collision.
- [ ] Photos captured from front, rear, and side for the next CAD iteration.

#### If V3 fails

Record which pad(s) touch, which do not, and where any collision occurs. Change one parameter at a time (`CONTACT_PCD`, `CONTACT_PAD_HEIGHT`, or `GAUGE_OUTER_DIAMETER`) rather than inventing a new full-console contour.
