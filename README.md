# Original / Fat PlayStation 5 Disc Edition Vertical Stand

Parametric, 3D-printable vertical stand and calibration coupon designed specifically for the **Original / Fat PlayStation 5 Disc Edition** (launch-family **CFI-1000** model group, e.g., **CFI-1015A**).

> **Compatibility Notice:**  
> This stand is engineered specifically for the **PS5 Fat Disc Edition** (CFI-1000 series). It is **NOT** designed for PS5 Slim (CFI-2000) or PS5 Pro (CFI-7000) models, which use different mounting geometry.

---

## Quick Start & Validation Workflow

We use a **two-stage verification strategy**:

1. **Step 1 — Print the Calibration Coupon (`ps5-fat-fit-test.stl` or `ps5-fat-fit-test.3mf`)**:
   - Small, low-filament test piece (~33g PETG, ~30–40 min print).
   - Contains the exact 1:1 mating cradle contour, locating lip, central seating boss, and screw axis.
   - Includes 4 sightline inspection windows to visually confirm flush seating against the console underside.
2. **Step 2 — Test on Powered-Off PS5**:
   - Place the coupon against the bottom of your powered-off PS5 Disc console.
   - Verify that the locating perimeter sits snugly without rocking, the screw hole aligns perfectly with the factory threaded insert, and peripheral vents are unobstructed.
3. **Step 3 — Print Production Stand**:
   - Print `ps5-fat-vertical-stand.stl` (for original Sony screw) or `ps5-fat-vertical-stand-alt-fastener.stl` (for standard M3 machine hardware).

---

## Files in this Repository

| File | Description | Format | Est. Print Mass (PETG) |
| :--- | :--- | :--- | :--- |
| `ps5-fat-fit-test.3mf` | **Ready-to-Print Project:** Calibration coupon pre-configured for Prusa MK4S + PETG | PrusaSlicer Project | ~33 g |
| `ps5-fat-vertical-stand.3mf` | **Ready-to-Print Project:** Production stand pre-configured for Prusa MK4S + PETG | PrusaSlicer Project | ~108 g |
| `ps5-fat-vertical-stand-alt-fastener.3mf`| **Ready-to-Print Project:** M3 hardware stand pre-configured for Prusa MK4S + PETG | PrusaSlicer Project | ~108 g |
| `ps5-fat-fit-test.stl` | **Output A:** Calibration / Fit test coupon | Raw STL Mesh | ~33 g |
| `ps5-fat-vertical-stand.stl` | **Output B:** Production Stand (Sony captive screw) | Raw STL Mesh | ~108 g |
| `ps5-fat-vertical-stand-alt-fastener.stl` | **Output C:** Stand for standard M3 hardware | Raw STL Mesh | ~108 g |
| `ps5_stand.scad` | Master parametric OpenSCAD source file | CAD Source | — |
| `scripts/build_models.py` | Automated STL compilation pipeline | Python CLI | — |
| `scripts/generate_3mf.py` | Automated PrusaSlicer 3MF project generator | Python CLI | — |
| `scripts/verify_mesh.py` | Automated quality control & manifold verification | Python + Trimesh | — |

---

## Reference Evidence & Dimension Classification

Every dimension in this project is explicitly classified by epistemic certainty:

| Dimension / Parameter | Value | Classification | Source / Engineering Rationale |
| :--- | :--- | :--- | :--- |
| **Console Vertical Height** | 390 mm | **VERIFIED** | Sony official launch specification (CFI-1015A) |
| **Console Width at Disc Bulge** | 104 mm | **VERIFIED** | Sony official launch specification |
| **Console Depth (Front-to-Rear)** | 260 mm | **VERIFIED** | Sony official launch specification |
| **Console Mass** | ~4.5 kg | **VERIFIED** | Sony official launch specification |
| **Console Factory Mounting Thread** | M3 × 0.5 mm | **VERIFIED** | iFixit teardown & hardware confirmation |
| **Sony Factory Stand Screw Length** | 26.5 mm | **VERIFIED** | iFixit measurement of captive stand screw |
| **Sony Official Stand Footprint** | 155 mm | **VERIFIED** | Sony CFI-ZVS1 vertical stand base diameter |
| **Stand Base Footprint (`BASE_DIAMETER`)** | 160.0 mm | **INFERRED** | Provides +5 mm stability margin over 155 mm reference |
| **Baseplate Thickness (`BASE_THICKNESS`)** | 12.0 mm | **INFERRED** | Structural rigidity under 4.5 kg console load |
| **Locating Lip Height (`CRADLE_HEIGHT`)** | 6.0 mm | **REFERENCE** | Community models (CrossfireZ / christiankirch) |
| **Chassis Waist Span (`CRADLE_WIDTH_NOMINAL`)**| 84.0 mm | **REFERENCE** | Physical PS5 Fat black chassis measurement |
| **Disc Bulge Offset (`CRADLE_DISC_BULGE`)** | 14.0 mm | **REFERENCE** | Asymmetric drive housing contour (+X side) |
| **Locating Span Depth (`CRADLE_LENGTH`)** | 108.0 mm | **REFERENCE** | Front-to-rear cradle locating contour |
| **Primary Screw Bore (`SCREW_HOLE_DIAMETER`)** | 4.2 mm | **REFERENCE** | Clearance for 3.8–4.0 mm unthreaded captive shank |
| **Primary Counterbore $\varnothing$** | 15.5 mm | **REFERENCE** | Recess for 13.5–14.0 mm Sony coin/thumb head |
| **Alt Screw Bore (M3 Hardware)** | 3.6 mm | **INFERRED** | ISO standard clearance hole for M3 screw |
| **Alt Counterbore $\varnothing$ (M3 Hardware)** | 10.5 mm | **INFERRED** | Recess for DIN 125 / DIN 9021 M3 washer + tool |
| **Screw Seat Thickness** | 7.0 mm | **INFERRED** | Leaves 19.5 mm screw reach into console chassis |
| **Cradle Clearance (`CRADLE_CLEARANCE`)** | 0.6 mm | **INFERRED** | FDM PETG shrinkage and fit tolerance |
| **Vent Channel Width / Depth** | 18 mm / 4.5 mm | **INFERRED** | Preserves unrestricted airflow around perimeter |
| **Foot Recess Diameter / Depth** | 10.5 mm / 1.2 mm | **INFERRED** | Sized for standard 10 mm adhesive silicone feet |

---

## Fastener Strategy

### 1. Primary Model: Original Sony Stand Screw (`ps5-fat-vertical-stand.stl` / `.3mf`)
- Designed for reuse of the **original Sony stand screw** (or 1:1 aftermarket replacements).
- Screw specifications:
  - Total length: ~26.5 mm
  - Thread: M3 × 0.5 mm (top ~12–14 mm)
  - Unthreaded shank: ~3.8–4.0 mm $\varnothing$
  - Head: ~13.5–14.0 mm $\varnothing$ coin/slotted thumb head
- Counterbore: $\varnothing 15.5\text{ mm}$, depth 5.0 mm, leaving a **7.0 mm solid PETG seat**. The screw protrudes ~19.5 mm upwards to securely engage the factory threaded insert.

### 2. Alternate Model: Standard M3 Hardware (`ps5-fat-vertical-stand-alt-fastener.stl` / `.3mf`)
- Designed for standard **metric M3 machine screws**:
  - Recommended fastener: **M3 × 25 mm** (or M3 × 20 mm) socket head / pan head screw + **M3 flat washer** (OD ~7.0–9.0 mm).
  - Counterbore: $\varnothing 10.5\text{ mm}$, through-hole: $\varnothing 3.6\text{ mm}$.
- Threads cleanly into the factory metal insert without any self-tapping or console modification.

---

## Recommended 3D Print Settings (Prusa MK4S)

| Setting | Recommendation | Rationale |
| :--- | :--- | :--- |
| **Material** | **PETG** (e.g. Overture / Prusament) | Warm exhaust air from PS5 (~50–60°C) can cause PLA to creep/sag over time. PETG has a Heat Deflection Temp of ~75°C. |
| **Preset Profile** | `0.20mm STRUCTURAL` | Optimized balance of strength, dimensional precision, and print speed on MK4S. |
| **Print Orientation** | Flat on base ($Z = 0$) | 100% support-free printing. Base has a built-in 45° chamfer to prevent elephant's foot. |
| **Perimeters / Walls** | **4 walls** (min 1.6–2.0 mm shell) | High perimeter count provides a rigid solid column around the mounting screw hole. |
| **Top / Bottom Layers** | **5 top / 5 bottom** (~1.0 mm solid) | Ensures stiff load distribution across the 160 mm base. |
| **Infill** | **20% Gyroid** | Gyroid provides isotropic resistance against twisting and compression under 4.5 kg console weight. |
| **Supports** | **None** | All overhangs and transitions are designed with $\le 45^\circ$ chamfers. |
| **Brim** | Optional (5 mm if bed adhesion is weak) | Helps prevent corner warping on PETG prints. |

---

## How to Test the Fit Coupon (`ps5-fat-fit-test.stl` / `.3mf`)

1. **Print the Coupon**:
   - Sliced with the standard PETG settings above.
   - Takes ~30–40 minutes and uses ~33g of filament.
2. **Inspect the Console Underside**:
   - Power off and unplug your PS5 Disc Edition.
   - If present, remove the small black circular plastic screw cap from the center bottom of the console (store it safely).
3. **Place the Coupon against the Console**:
   - Note the embossed `"FRONT"` indicator on the coupon floor; orient this toward the front power/eject buttons of the console.
   - The wider asymmetric cradle expansion (+X side) naturally seats around the disc drive housing.
4. **Check Physical Verification Criteria**:
   - **Contour Seating**: The locating lip should snugly cup the black center chassis without binding or scraping the white side panels.
   - **Screw Alignment**: Look through the center through-hole from the underside. The factory metal threaded insert should be perfectly concentric with the printed hole.
   - **Flush Contact**: Inspect through the 4 sightline windows (front, rear, left, right). The bottom chassis must sit flat on the floor pad without rocking.
   - **Ventilation**: Verify that the peripheral vent channels along the lower black chassis remain open to ambient air.

---

## Parametric Tuning Guide (`ps5_stand.scad`)

If your test print requires adjustments due to printer tolerances, filament shrinkage, or hardware variations, open `ps5_stand.scad` and tweak the corresponding parameters:

| Symptom / Requirement | Parameter to Modify | Default Value | Adjustment Recommendation |
| :--- | :--- | :--- | :--- |
| **Cradle too tight / binds console** | `CRADLE_CLEARANCE` | `0.6` (mm) | Increase to `0.8` or `1.0` mm |
| **Cradle too loose / excess play** | `CRADLE_CLEARANCE` | `0.6` (mm) | Decrease to `0.4` or `0.3` mm |
| **Screw hole too tight on shank** | `SCREW_HOLE_DIAMETER` | `4.2` / `3.6` (mm) | Increase by `+0.2` to `+0.4` mm |
| **Screw head doesn't fit in recess** | `SCREW_COUNTERBORE_DIAMETER` | `15.5` / `10.5` (mm) | Increase by `+1.0` mm |
| **Screw thread doesn't reach insert** | `SCREW_COUNTERBORE_DEPTH` | `5.0` (mm) | Increase to `6.0` or `7.0` mm (reduces seat thickness) |
| **Screw bottoms out too early** | `SCREW_COUNTERBORE_DEPTH` | `5.0` (mm) | Decrease to `3.5` or `4.0` mm (thickens seat) |
| **Want larger footprint for stability** | `BASE_DIAMETER` | `160.0` (mm) | Adjust between `155.0` and `175.0` mm |
| **Using different rubber feet size** | `FOOT_DIAMETER`, `FOOT_DEPTH` | `10.5` / `1.2` (mm) | Measure bumper pad diameter and set `+0.5` mm clearance |

### Rebuilding STLs and 3MF Projects
Run the automated build scripts:
```bash
python scripts/build_models.py
python scripts/generate_3mf.py
python scripts/verify_mesh.py
```
