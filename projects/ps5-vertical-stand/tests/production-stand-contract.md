# Production Stand Contract — V4

This contract is intentionally written before production CAD. It converts the V3 physical pass into explicit requirements.

## Shared body requirements

- Reuse the V3 mounting-axis origin unchanged.
- Reuse the V3 three-pad contact pattern unchanged unless later physical evidence requires otherwise.
- Production footprint target: 160 mm diameter (155 mm Sony reference + 5 mm margin).
- Flat printable underside.
- No wall or cradle may extend into the 48 mm V3 no-collision envelope above the proven interface.
- The stand must expose the factory mounting axis as a true through-bore.
- OEM and replacement variants must share identical body/contact geometry; only fastener-seat geometry may differ.

## OEM-style fastener variant

- Evidence: iFixit verifies the original PS5 stand screw total length is 26.5 mm.
- Exact thread diameter/pitch is not claimed by this project.
- Bore is a clearance passage only; it must never print threads intended to engage the console.
- Counterbore is intentionally conservative and parameterized for later adjustment around an OEM-style captive replacement screw.

## Aftermarket replacement variant

- Evidence: ZedLabz sells a replacement captive stand screw specifically for original PS5 CFI-1000/1100/1200 stands and describes it as matching the original Sony captive screw.
- Because that source does not publish dimensional thread/head specs, this variant uses the same conservative OEM-style envelope until the actual purchased screw is measured.
- Do not substitute generic M3/M4 hardware into the PS5 factory insert based only on internet claims.

## Automated geometry checks

The generated production variants must prove:

- 160 mm XY footprint within tolerance.
- Watertight mesh and consistent winding.
- Center bore remains open through the entire body.
- OEM and replacement variants have equal external bounds.
- V3 contact pad centers remain at the same X/Y coordinates and pad height relative to the console-contact plane.

## Physical validation gate

Automated checks do not prove final PS5 compatibility. After printing one production variant:

- console must stand vertically without rocking;
- all three proven contact pads must remain seated;
- stand must not touch white panels or block vents;
- fastener must engage without force or bottoming out;
- final result must be recorded in `fit-log.md` before status becomes Production Verified.
