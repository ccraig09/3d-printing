# 3D Printing & CAD Vault 🖨️📐

Personal collection of parametric 3D printable designs, functional engineering parts, and pre-configured PrusaSlicer project files.

---

## 🛠️ Lab & Printer Specifications

- **Primary 3D Printer:** Original Prusa MK4S (0.4mm High-Flow Nozzle / HF0.4)
- **Primary Slicer:** PrusaSlicer (2.9+)
- **Standard Materials:** 
  - **PETG** (Overture / Prusament) — High strength, thermal resistance (~75°C HDT), functional mounts/stands.
  - **PLA** — Prototyping and indoor aesthetic parts.
- **CAD Environment:** Parametric OpenSCAD, FreeCAD, and STEP exports.

---

## 📂 Project Catalog

| # | Project Name | Category | Target Hardware / Problem | Key Materials | Status |
| :-: | :--- | :--- | :--- | :--- | :-: |
| **01** | [**PS5 Fat Vertical Stand**](./projects/ps5-vertical-stand) | Gaming / Stands | Original PS5 Disc Edition (CFI-1000 family) | PETG | ✅ Complete |
| **--** | *More functional prints coming soon...* | — | — | — | ⏳ In Dev |

---

## 🗂️ Repository Structure

```text
3d-printing/
├── README.md                          # Master Project Catalog & Lab Specs (This file)
├── .gitignore                         # Slicer, cache, and large binary exclusions
│
├── projects/                          # Production 3D printing projects
│   └── ps5-vertical-stand/            # ⭐ Project #01: PS5 Vertical Stand
│       ├── ps5-fat-fit-test.stl       # Fast calibration coupon (~33g)
│       ├── ps5-fat-vertical-stand.stl # Production stand (Sony screw)
│       ├── ps5-fat-vertical-stand.3mf # Prusa MK4S pre-configured project
│       ├── ps5_stand.scad             # Master parametric CAD source
│       ├── README.md                  # Detailed dimensions, tolerances & BOM
│       └── scripts/                   # Automated compilation & mesh QC
│
└── templates/                         # Standardized project boilerplate
    └── project-template/              # Starter template for future prints
        ├── README.md                  # Pre-formatted BOM & print settings template
        └── model.scad                 # Starter parametric CAD script
```

---

## 🚀 How to Start a New Project

Whenever you begin a new 3D design:

1. **Scaffold the new project folder**:
   ```bash
   cp -r templates/project-template projects/my-new-print
   ```
2. **Develop the CAD model**:
   - Open `projects/my-new-print/model.scad` and define parametric dimensions.
   - Export `.stl` and configure `.3mf` in PrusaSlicer.
3. **Document**:
   - Update `projects/my-new-print/README.md` with hardware BOM and recommended slicer settings.
4. **Index in Catalog**:
   - Add a row to the table above in this root `README.md`.
5. **Commit & Push**:
   ```bash
   git add .
   git commit -m "feat: add my-new-print project"
   git push origin main
   ```
