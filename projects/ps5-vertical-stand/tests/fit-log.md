# PS5 Vertical Stand — Physical Fit Log

This file is the physical source of truth. Computational mesh checks do not prove console fit.

## Console
- Target: Original / Fat PlayStation 5 Disc Edition, CFI-1000 family
- User-confirmed hardware: original/fat Disc Edition

## Prototype history

### V1 — FAIL
- Failed physical fit.
- Broad underside geometry was inferred rather than dimensionally established.

### V2 / V2.1 — NOT ACCEPTED AS VALIDATED
- Automated QC proved mesh properties, not PS5 compatibility.
- Prior production artifacts are not considered verified.

### V3 — PHYSICALLY VERIFIED PASS
- Date: 2026-08-29
- Artifact: `ps5-fat-fit-test-v3.stl`
- Geometry: 48 mm gauge, center bore, three 8 mm contact pads on 30 mm PCD, 0.8 mm pad height.
- User result: **PASS — flat, no wobble, good seating.**
- The exact V3 mounting-axis origin and three-pad contact geometry are now physically verified for reuse.

### V4 — PRODUCTION CANDIDATE
Status: **CAD/computational validation complete; final physical stand validation pending.**

Shared body:
- 160 mm footprint
- 10 mm base thickness
- exact V3 contact geometry reused
- 5 mm center clearance bore
- four optional rubber-foot recesses
- no enclosing PS5 cradle walls

Fastener variants:
1. `ps5-fat-vertical-stand-oem.stl` — for original Sony captive stand screw or exact OEM-style replacement.
2. `ps5-fat-vertical-stand-replacement.stl` — for an aftermarket captive replacement specifically sold for original PS5 CFI-1000/1100/1200 stands.

The two variants currently use the same conservative fastener envelope. iFixit verifies the original stand screw is 26.5 mm overall length, but this project does not claim a verified thread diameter/pitch. Measure the actual replacement before narrowing the parameterized bore/counterbore.

#### V4 physical acceptance checklist
- [ ] Console stands vertically without rocking.
- [ ] All three V3-derived pads remain seated.
- [ ] No contact with white panels or blocked vents.
- [ ] Fastener engages smoothly without being forced.
- [ ] Fastener clamps the stand before reaching its travel limit.
- [ ] Photos captured for final validation record.

Do not mark the project Production Verified until this checklist passes on the real console.
