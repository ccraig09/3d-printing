# 3D Printing & CAD Vault 🖨️📐

Personal collection of parametric 3D-printable designs, functional engineering experiments, calibration artifacts, and production-ready parts.

The repo is intentionally organized as a **maker engineering notebook**, not just a folder of STLs: design assumptions, physical test evidence, CAD source, and printable exports should stay together.

## Lab & Printer

- **Primary printer:** Original Prusa MK4S, 0.4 mm nozzle
- **Primary slicer:** PrusaSlicer
- **Common materials:** PETG for functional/thermal parts, PLA for low-stress prototypes
- **CAD:** OpenSCAD first when parametric iteration is useful; other native CAD/STEP sources are welcome

## Project catalog

| # | Project | Category | Material | Status |
| :-: | --- | --- | --- | --- |
| **01** | [PS5 Fat Vertical Stand](./projects/ps5-vertical-stand) | Gaming / Stand | PETG | 🧪 **Recovery V3 — fit validation** |
| -- | More projects coming | — | — | ⏳ |

## Standard project lifecycle

```text
idea / problem
   ↓
research + evidence classification
   ↓
parametric CAD
   ↓
computational mesh checks
   ↓
small physical calibration print
   ↓
fit log + photos
   ↓
production model
   ↓
PrusaSlicer native project
   ↓
final physical validation
```

**Important:** computational QC does not prove physical fit. A project is only physically verified when the real-world test is recorded.

## Repository structure

```text
3d-printing/
├── README.md
├── .gitignore
├── projects/
│   └── ps5-vertical-stand/
│       ├── README.md
│       ├── ps5_stand.scad
│       ├── ps5-fat-fit-test-v3.stl
│       ├── scripts/
│       │   ├── build_models.py
│       │   └── verify_mesh.py
│       └── tests/
│           └── fit-log.md
└── templates/
    └── project-template/
        ├── README.md
        ├── model.scad
        └── tests/
            └── fit-log.md
```

As projects grow, `cad/`, `exports/`, and `slicer/` subfolders can be introduced when they reduce clutter. Do not add folder ceremony before a project earns it.

## Start a new project

```bash
cp -r templates/project-template projects/my-new-print
```

Then:

1. Write the problem and evidence in the project README.
2. Keep uncertain dimensions labeled as **INFERRED**.
3. Build the smallest calibration artifact that can answer the current physical question.
4. Record every physical attempt in `tests/fit-log.md`.
5. Promote an export to “production-ready” only after physical validation.
6. Save `.3mf` projects from PrusaSlicer itself when exact printer/filament settings matter.
