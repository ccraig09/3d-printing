# [Project Name]

[Brief 1-2 sentence description of what this part is and what problem it solves.]

---

## Hardware & Bill of Materials (BOM)

| Item | Specification / Dimension | Quantity | Notes |
| :--- | :--- | :--- | :--- |
| **Fastener** | e.g. M3 × 12mm Button Head | 2 | Secures bracket to desk |
| **Nut / Insert** | e.g. M3 Heat-set brass insert (OD 4.6mm, L 4.0mm) | 2 | Melted into printed boss |
| **Padding** | e.g. 10mm adhesive rubber bumper | 4 | Anti-slip desk feet |

---

## 3D Print Settings (Recommended)

| Parameter | Recommended Setting | Rationale |
| :--- | :--- | :--- |
| **Printer** | Original Prusa MK4S (0.4mm nozzle) | — |
| **Filament** | PETG / PLA / ASA | [Explain material choice based on mechanical / thermal stress] |
| **Layer Height** | `0.20mm STRUCTURAL` | Balanced strength and surface finish |
| **Perimeters (Walls)**| 4 walls | Provides solid mechanical core |
| **Top / Bottom** | 5 top / 5 bottom | Prevents top layer pillowing / bottom flex |
| **Infill** | 20% Gyroid | Isotropic rigidity |
| **Supports** | None (or specify custom enforcers) | Chamfers allow support-free printing |

---

## Files in this Project

| File | Type | Description |
| :--- | :--- | :--- |
| `model.scad` | CAD Source | Fully parametric OpenSCAD design |
| `output.stl` | STL Mesh | Universal 3D geometry |
| `output.3mf` | Slicer Project | Pre-configured plate layout & settings |

---

## Parametric Customization Guide

If adjusting dimensions in `model.scad`:

| Variable Name | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `50.0` | Total part width in mm |
| `CLEARANCE` | `0.4` | Fit tolerance gap |
| `SCREW_HOLE_DIA` | `3.6` | Clearance hole for M3 screws |
