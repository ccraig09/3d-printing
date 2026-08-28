// =============================================================================
// OpenSCAD Parametric Template
// Project: [Project Name]
// =============================================================================

/* [Main Dimensions] */
PART_WIDTH  = 60.0;
PART_DEPTH  = 40.0;
PART_HEIGHT = 20.0;
WALL_THICK  = 3.5;
CHAMFER     = 2.0;

/* [Fasteners & Tolerances] */
SCREW_DIA   = 3.6; // M3 clearance
TOLERANCE   = 0.4; // 3D print fit clearance

/* [Resolution] */
$fn = $preview ? 32 : 128;

module base_part() {
    difference() {
        // Outer body
        cube([PART_WIDTH, PART_DEPTH, PART_HEIGHT], center = true);

        // Center mounting hole
        cylinder(r = SCREW_DIA / 2, h = PART_HEIGHT + 2.0, center = true);
    }
}

// Render
base_part();
