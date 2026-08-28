// =============================================================================
// OpenSCAD Parametric Model: Original/Fat PS5 Disc Edition Vertical Stand
// Target Console: PlayStation 5 Disc Edition (CFI-1000 Family, e.g. CFI-1015A)
// Material: PETG | Print Orientation: Flat on bed | Supports: None Required
// =============================================================================

/* [Render Selection] */
// Select the output mode to render:
// "STAND"      : Full 160mm production vertical stand for original Sony screw
// "FIT_TEST"   : Compact low-filament calibration coupon for fit verification
// "ALT_STAND"  : Production stand optimized for standard M3 machine hardware
MODE = "STAND"; // [STAND, FIT_TEST, ALT_STAND]

/* [Base Dimensions] */
// Overall outer footprint diameter (Sony CFI-ZVS1 reference is 155mm)
BASE_DIAMETER = 160.0; // [140:1:180]
// Solid baseplate thickness
BASE_THICKNESS = 12.0; // [8:0.5:20]
// Lower bed chamfer to eliminate elephant's foot and ease removal
BASE_BOTTOM_CHAMFER = 2.0;
// Upper perimeter chamfer for sleek aesthetics and smooth edge
BASE_TOP_CHAMFER = 2.0;

/* [PS5 Mating Cradle Geometry] */
// Front-to-back locating span of the mating cradle
CRADLE_LENGTH = 108.0;
// Central black chassis waist width (nominal)
CRADLE_WIDTH_NOMINAL = 84.0;
// Additional asymmetric bulge width on the disc drive side (+X direction)
CRADLE_DISC_BULGE = 14.0;
// Locating lip containment height above the baseplate
CRADLE_HEIGHT = 6.0;
// Structural wall thickness of the locating lip
CRADLE_WALL = 3.5;
// Fit tolerance / clearance gap around the console body (PETG shrinkage allowance)
CRADLE_CLEARANCE = 0.6;
// Lead-in guide chamfer on the top edge of the locating lip
CRADLE_LEAD_CHAMFER = 1.8;

/* [Fastener Configuration] */
// Fastener type preset: "SONY" (Original Sony Stand Screw) or "M3" (Metric M3 Hardware)
FASTENER_TYPE = (MODE == "ALT_STAND") ? "M3" : "SONY";

// Clearance hole through-diameter for screw shank
SCREW_HOLE_DIAMETER = (FASTENER_TYPE == "SONY") ? 4.2 : 3.6;
// Underside counterbore recess diameter for screw head / washer
SCREW_COUNTERBORE_DIAMETER = (FASTENER_TYPE == "SONY") ? 15.5 : 10.5;
// Underside counterbore depth
SCREW_COUNTERBORE_DEPTH = 5.0;
// Resulting solid seat thickness under the screw head
SCREW_SEAT_THICKNESS = BASE_THICKNESS - SCREW_COUNTERBORE_DEPTH; // 7.0mm nominal

// Screw axis position relative to stand origin
SCREW_X = 0.0;
SCREW_Y = 0.0;

/* [Ventilation Channels] */
// Width of radial airflow cutouts across the locating lip
VENT_CHANNEL_WIDTH = 18.0;
// Depth of airflow cutouts below the top of the cradle
VENT_CHANNEL_DEPTH = 4.5;

/* [Underside Anti-Slip Foot Recesses] */
// Diameter for adhesive rubber / silicone bumper feet (standard 10mm pads)
FOOT_DIAMETER = 10.5;
// Shallow recess depth (stand sits flat even if pads are omitted)
FOOT_DEPTH = 1.2;
// Pitch circle diameter (PCD) for the 4 foot recesses
FOOT_PCD = 118.0;

/* [Fit Test Coupon Specific Dimensions] */
// Base thickness for coupon (reduced for fast printing & minimal filament)
COUPON_BASE_THICKNESS = 4.0;

/* [Mesh Resolution] */
$fn = $preview ? 64 : 128;


// =============================================================================
// 2D PROFILE HELPERS (PS5 Fat Disc Contour)
// =============================================================================

// PS5 Fat Disc Base 2D profile
module ps5_fat_disc_profile(clearance = 0) {
    w_left = (CRADLE_WIDTH_NOMINAL / 2) + clearance;
    w_right = (CRADLE_WIDTH_NOMINAL / 2) + CRADLE_DISC_BULGE + clearance;
    len_half = (CRADLE_LENGTH / 2) + clearance;
    r_corner = 14.0;

    hull() {
        // Front-left corner
        translate([-w_left + r_corner, len_half - r_corner])
            circle(r = r_corner);
        // Rear-left corner
        translate([-w_left + r_corner, -len_half + r_corner])
            circle(r = r_corner);
        // Front-right (disc side) corner
        translate([w_right - r_corner - 2, len_half - r_corner - 4])
            circle(r = r_corner + 2);
        // Rear-right (disc side) corner
        translate([w_right - r_corner, -len_half + r_corner])
            circle(r = r_corner);
        // Disc drive lateral bulge expansion
        translate([w_right - r_corner, 0])
            circle(r = r_corner + 4);
    }
}


// =============================================================================
// UNIFIED CAVITY CUTTER (Single continuous manifold boolean cutter)
// =============================================================================
module console_cavity_cutter(z_base, h_lip, lead_chamfer, clr = CRADLE_CLEARANCE) {
    h_straight = h_lip - lead_chamfer;
    
    translate([0, 0, z_base]) {
        // Straight lower cavity
        linear_extrude(height = h_straight + 0.01) {
            ps5_fat_disc_profile(clearance = clr);
        }
        
        // Chamfered upper lead-in transition
        translate([0, 0, h_straight]) {
            hull() {
                linear_extrude(height = 0.01) {
                    ps5_fat_disc_profile(clearance = clr);
                }
                translate([0, 0, lead_chamfer + 1.0]) {
                    linear_extrude(height = 0.01) {
                        ps5_fat_disc_profile(clearance = clr + lead_chamfer + 1.0);
                    }
                }
            }
        }
    }
}


// =============================================================================
// STAND COMPONENTS
// =============================================================================

// 1. Solid Base Plate with chamfers
module base_plate() {
    difference() {
        // Main cylinder
        cylinder(r = BASE_DIAMETER / 2, h = BASE_THICKNESS);

        // Bottom print chamfer (45 deg)
        translate([0, 0, -1.0])
            difference() {
                cylinder(r = (BASE_DIAMETER / 2) + 5, h = BASE_BOTTOM_CHAMFER + 1.0);
                cylinder(
                    r1 = (BASE_DIAMETER / 2) - BASE_BOTTOM_CHAMFER - 1.0,
                    r2 = BASE_DIAMETER / 2,
                    h = BASE_BOTTOM_CHAMFER + 1.0
                );
            }

        // Top perimeter chamfer (45 deg)
        translate([0, 0, BASE_THICKNESS - BASE_TOP_CHAMFER])
            difference() {
                cylinder(r = (BASE_DIAMETER / 2) + 5, h = BASE_TOP_CHAMFER + 1.0);
                cylinder(
                    r1 = BASE_DIAMETER / 2,
                    r2 = (BASE_DIAMETER / 2) - BASE_TOP_CHAMFER - 1.0,
                    h = BASE_TOP_CHAMFER + 1.0
                );
            }
    }
}

// 2. Locating Cradle Rim Solid (before cavity cut)
module mating_cradle_solid() {
    total_height = BASE_THICKNESS + CRADLE_HEIGHT;
    linear_extrude(height = total_height) {
        ps5_fat_disc_profile(clearance = CRADLE_CLEARANCE + CRADLE_WALL);
    }
}

// 3. Radial Ventilation Channels
module ventilation_channels(z_base = BASE_THICKNESS, h_lip = CRADLE_HEIGHT, depth = VENT_CHANNEL_DEPTH) {
    z_cut_start = z_base + h_lip - depth;
    h_cut = depth + 2.0;
    
    // Front and Rear vent channels (along Y axis)
    translate([0, 0, z_cut_start + h_cut / 2])
        cube([VENT_CHANNEL_WIDTH, BASE_DIAMETER * 1.2, h_cut], center = true);

    // Left and Right vent channels (along X axis)
    translate([0, 0, z_cut_start + h_cut / 2])
        cube([BASE_DIAMETER * 1.2, VENT_CHANNEL_WIDTH, h_cut], center = true);
        
    // Angled corner vent channels (45 deg) for maximum perimeter air circulation
    rotate([0, 0, 45])
        translate([0, 0, z_cut_start + h_cut / 2])
            cube([BASE_DIAMETER * 1.2, VENT_CHANNEL_WIDTH * 0.8, h_cut], center = true);
            
    rotate([0, 0, -45])
        translate([0, 0, z_cut_start + h_cut / 2])
            cube([BASE_DIAMETER * 1.2, VENT_CHANNEL_WIDTH * 0.8, h_cut], center = true);
}

// 4. Fastener Bore and Counterbore
module fastener_cutout(base_th = BASE_THICKNESS, cb_depth = SCREW_COUNTERBORE_DEPTH) {
    h_total = base_th + CRADLE_HEIGHT + 10.0;
    taper_h = (SCREW_COUNTERBORE_DIAMETER - SCREW_HOLE_DIAMETER) / 2;
    
    translate([SCREW_X, SCREW_Y, 0]) {
        // Through-hole for screw thread/shank extending through entire part
        translate([0, 0, -2.0])
            cylinder(r = SCREW_HOLE_DIAMETER / 2, h = h_total);

        // Underside counterbore for screw head / washer
        translate([0, 0, -2.0])
            cylinder(r = SCREW_COUNTERBORE_DIAMETER / 2, h = cb_depth + 2.0);

        // 45-degree transition from counterbore to through-hole to eliminate overhangs
        translate([0, 0, cb_depth])
            cylinder(
                r1 = SCREW_COUNTERBORE_DIAMETER / 2,
                r2 = SCREW_HOLE_DIAMETER / 2,
                h = taper_h
            );
    }
}

// 5. Underside Rubber Foot Recesses
module foot_recesses() {
    radius_pcd = FOOT_PCD / 2;
    for (angle = [45, 135, 225, 315]) {
        rotate([0, 0, angle])
            translate([radius_pcd, 0, -0.5])
                cylinder(r = FOOT_DIAMETER / 2, h = FOOT_DEPTH + 0.5);
    }
}


// =============================================================================
// MAIN ASSEMBLY: PRODUCTION VERTICAL STAND
// =============================================================================
module production_vertical_stand() {
    difference() {
        // Union of solid base and outer cradle envelope
        union() {
            base_plate();
            intersection() {
                mating_cradle_solid();
                cylinder(r = (BASE_DIAMETER / 2) - BASE_TOP_CHAMFER, h = BASE_THICKNESS + CRADLE_HEIGHT + 2.0);
            }
        }

        // 1. Subtract unified console mating cavity with lead-in chamfer
        console_cavity_cutter(
            z_base = BASE_THICKNESS,
            h_lip = CRADLE_HEIGHT,
            lead_chamfer = CRADLE_LEAD_CHAMFER,
            clr = CRADLE_CLEARANCE
        );

        // 2. Subtract ventilation channels
        ventilation_channels(
            z_base = BASE_THICKNESS,
            h_lip = CRADLE_HEIGHT,
            depth = VENT_CHANNEL_DEPTH
        );

        // 3. Subtract center fastener through-hole & counterbore
        fastener_cutout(BASE_THICKNESS, SCREW_COUNTERBORE_DEPTH);

        // 4. Subtract underside anti-slip foot pockets
        foot_recesses();
    }
}


// =============================================================================
// CALIBRATION COUPON: FIT TEST (Output A)
// =============================================================================
module fit_test_coupon() {
    total_coupon_h = COUPON_BASE_THICKNESS + CRADLE_HEIGHT;
    difference() {
        // Base envelope: Extrusion of outer cradle boundary
        linear_extrude(height = total_coupon_h) {
            ps5_fat_disc_profile(clearance = CRADLE_CLEARANCE + CRADLE_WALL);
        }

        // 1. Subtract exact 1:1 inner cavity with lead-in chamfer
        console_cavity_cutter(
            z_base = COUPON_BASE_THICKNESS,
            h_lip = CRADLE_HEIGHT,
            lead_chamfer = CRADLE_LEAD_CHAMFER,
            clr = CRADLE_CLEARANCE
        );

        // 2. Sightline inspection windows on front, rear, left, right to visually inspect flush seating
        translate([0, (CRADLE_LENGTH / 2) + CRADLE_CLEARANCE, COUPON_BASE_THICKNESS + 2.0])
            cube([24.0, 15.0, CRADLE_HEIGHT + 4.0], center = true);

        translate([0, -(CRADLE_LENGTH / 2) - CRADLE_CLEARANCE, COUPON_BASE_THICKNESS + 2.0])
            cube([24.0, 15.0, CRADLE_HEIGHT + 4.0], center = true);

        translate([-(CRADLE_WIDTH_NOMINAL / 2) - CRADLE_CLEARANCE, 0, COUPON_BASE_THICKNESS + 2.0])
            cube([15.0, 24.0, CRADLE_HEIGHT + 4.0], center = true);

        translate([(CRADLE_WIDTH_NOMINAL / 2) + CRADLE_DISC_BULGE + CRADLE_CLEARANCE, 0, COUPON_BASE_THICKNESS + 2.0])
            cube([15.0, 24.0, CRADLE_HEIGHT + 4.0], center = true);

        // 3. Through-hole & counterbore (exact same screw axis and bore as production)
        translate([SCREW_X, SCREW_Y, 0]) {
            translate([0, 0, -1.0])
                cylinder(r = SCREW_HOLE_DIAMETER / 2, h = total_coupon_h + 3.0);
            translate([0, 0, -1.0])
                cylinder(r = SCREW_COUNTERBORE_DIAMETER / 2, h = 2.0);
        }

        // 4. Embossed orientation indicator "FRONT" (recessed into floor)
        translate([0, (CRADLE_LENGTH / 2) - 16.0, COUPON_BASE_THICKNESS - 0.4])
            linear_extrude(height = 0.5)
                text("FRONT", size = 6.0, halign = "center", valign = "center", font = "Liberation Sans:style=Bold");
    }
}


// =============================================================================
// ROOT RENDER DISPATCHER
// =============================================================================
if (MODE == "FIT_TEST") {
    fit_test_coupon();
} else if (MODE == "ALT_STAND") {
    production_vertical_stand();
} else {
    // Default: "STAND" (Production Stand for Sony Screw)
    production_vertical_stand();
}
