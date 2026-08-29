// =============================================================================
// OpenSCAD Parametric Model: Original/Fat PS5 Disc Edition Vertical Stand (V2.1)
// Target Console: PlayStation 5 Disc Edition (CFI-1000 Family, e.g. CFI-1015A)
// Design Architecture: Open-Wing Anti-Twist Base (Engineered Zero-Collision)
// Material: PETG | Print Orientation: Flat on bed | Supports: None Required
// =============================================================================

/* [Render Selection] */
MODE = "STAND"; // [STAND, FIT_TEST, ALT_STAND]

/* [Base Dimensions] */
BASE_DIAMETER = 160.0; // [140:1:180] mm - Overall footprint diameter (155mm Sony ref + 5mm margin)
BASE_THICKNESS = 12.0;  // mm - Solid baseplate thickness for structural rigidity
BASE_BOTTOM_CHAMFER = 2.0;
BASE_TOP_CHAMFER = 2.0;

/* [Central Seating & Anti-Twist Geometry] */
// Width of the black chassis spine contact channel
CHASSIS_SPINE_WIDTH = 50.0;
// Front-to-back locating span
CHASSIS_SPINE_LENGTH = 98.0;
// Low-profile anti-twist locating lip height (prevents rotation without binding)
LOCATING_LIP_HEIGHT = 4.5;
// Locating lip wall thickness
LOCATING_LIP_WALL = 3.5;
// Generous 45-degree lead-in guide funnel
LEAD_CHAMFER = 2.2;
// Engineering fit clearance for PETG (forgiving slip-fit)
FIT_CLEARANCE = 1.2;

/* [Fastener Configuration] */
FASTENER_TYPE = (MODE == "ALT_STAND") ? "M3" : "SONY";

SCREW_HOLE_DIAMETER = (FASTENER_TYPE == "SONY") ? 4.2 : 3.6;
SCREW_COUNTERBORE_DIAMETER = (FASTENER_TYPE == "SONY") ? 15.5 : 10.5;
SCREW_COUNTERBORE_DEPTH = 5.0;
SCREW_SEAT_THICKNESS = BASE_THICKNESS - SCREW_COUNTERBORE_DEPTH; // 7.0mm

SCREW_X = 0.0;
SCREW_Y = 0.0;

/* [Underside Anti-Slip Foot Recesses] */
FOOT_DIAMETER = 10.5;
FOOT_DEPTH = 1.2;
FOOT_PCD = 118.0;

/* [Fit Test Coupon Dimensions] */
COUPON_WIDTH = 66.0;
COUPON_BASE_THICKNESS = 4.0;

/* [Mesh Resolution] */
$fn = $preview ? 64 : 128;


// 2D Profile of the black central chassis resting surface
module chassis_spine_profile(extra = 0) {
    w_half = (CHASSIS_SPINE_WIDTH / 2) + extra;
    len_half = (CHASSIS_SPINE_LENGTH / 2) + extra;
    r_corner = 14.0;

    hull() {
        translate([-w_half + r_corner, len_half - r_corner])
            circle(r = r_corner);
        translate([w_half - r_corner, len_half - r_corner])
            circle(r = r_corner);
        translate([-w_half + r_corner, -len_half + r_corner])
            circle(r = r_corner);
        translate([w_half - r_corner, -len_half + r_corner])
            circle(r = r_corner);
    }
}


// Unified Cavity Cutter (Single continuous manifold boolean cutter)
module chassis_cavity_cutter(z_base, h_lip, lead_chamfer, clr = FIT_CLEARANCE) {
    h_straight = h_lip - lead_chamfer;
    
    translate([0, 0, z_base]) {
        // Straight lower cavity
        linear_extrude(height = h_straight + 0.01) {
            chassis_spine_profile(extra = clr);
        }
        
        // Generous chamfered upper lead-in funnel
        translate([0, 0, h_straight]) {
            hull() {
                linear_extrude(height = 0.01) {
                    chassis_spine_profile(extra = clr);
                }
                translate([0, 0, lead_chamfer + 1.0]) {
                    linear_extrude(height = 0.01) {
                        chassis_spine_profile(extra = clr + lead_chamfer + 1.0);
                    }
                }
            }
        }
    }
}


// Solid Base Plate with chamfers
module base_plate() {
    difference() {
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


// Solid Locating Rim envelope
module locating_rim_solid(z_base, h_lip) {
    total_h = z_base + h_lip;
    linear_extrude(height = total_h) {
        chassis_spine_profile(extra = FIT_CLEARANCE + LOCATING_LIP_WALL);
    }
}


// Fastener Bore & Counterbore
module fastener_cutout(base_th, cb_depth) {
    h_total = base_th + LOCATING_LIP_HEIGHT + 10.0;
    taper_h = (SCREW_COUNTERBORE_DIAMETER - SCREW_HOLE_DIAMETER) / 2;
    
    translate([SCREW_X, SCREW_Y, 0]) {
        translate([0, 0, -2.0])
            cylinder(r = SCREW_HOLE_DIAMETER / 2, h = h_total);

        translate([0, 0, -2.0])
            cylinder(r = SCREW_COUNTERBORE_DIAMETER / 2, h = cb_depth + 2.0);

        translate([0, 0, cb_depth])
            cylinder(
                r1 = SCREW_COUNTERBORE_DIAMETER / 2,
                r2 = SCREW_HOLE_DIAMETER / 2,
                h = taper_h
            );
    }
}


// Underside Rubber Feet
module foot_recesses() {
    radius_pcd = FOOT_PCD / 2;
    for (angle = [45, 135, 225, 315]) {
        rotate([0, 0, angle])
            translate([radius_pcd, 0, -0.5])
                cylinder(r = FOOT_DIAMETER / 2, h = FOOT_DEPTH + 0.5);
    }
}


// MAIN PRODUCTION STAND
module production_vertical_stand() {
    difference() {
        union() {
            base_plate();
            intersection() {
                locating_rim_solid(BASE_THICKNESS, LOCATING_LIP_HEIGHT);
                cylinder(r = (BASE_DIAMETER / 2) - BASE_TOP_CHAMFER, h = BASE_THICKNESS + LOCATING_LIP_HEIGHT + 2.0);
            }
        }

        // 1. Subtract central cavity
        chassis_cavity_cutter(
            z_base = BASE_THICKNESS,
            h_lip = LOCATING_LIP_HEIGHT,
            lead_chamfer = LEAD_CHAMFER,
            clr = FIT_CLEARANCE
        );

        // 2. Open side wings (100% white panel clearance across entire midsection)
        translate([0, 0, BASE_THICKNESS + LOCATING_LIP_HEIGHT / 2])
            cube([BASE_DIAMETER * 1.5, CHASSIS_SPINE_LENGTH * 0.48, LOCATING_LIP_HEIGHT + 4.0], center = true);

        // 3. Fastener through-hole
        fastener_cutout(BASE_THICKNESS, SCREW_COUNTERBORE_DEPTH);

        // 4. Foot pockets
        foot_recesses();
    }
}


// CALIBRATION COUPON (V2.1)
module fit_test_coupon() {
    total_coupon_h = COUPON_BASE_THICKNESS + LOCATING_LIP_HEIGHT;
    
    difference() {
        union() {
            // Base plate of the coupon
            linear_extrude(height = COUPON_BASE_THICKNESS) {
                chassis_spine_profile(extra = FIT_CLEARANCE + LOCATING_LIP_WALL + 4.0);
            }
            // Locating rim envelope
            linear_extrude(height = total_coupon_h) {
                chassis_spine_profile(extra = FIT_CLEARANCE + LOCATING_LIP_WALL);
            }
        }

        // 1. Subtract central chassis cavity
        chassis_cavity_cutter(
            z_base = COUPON_BASE_THICKNESS,
            h_lip = LOCATING_LIP_HEIGHT,
            lead_chamfer = LEAD_CHAMFER,
            clr = FIT_CLEARANCE
        );

        // 2. Open side wings (100% clearance for white wings)
        translate([0, 0, COUPON_BASE_THICKNESS + LOCATING_LIP_HEIGHT / 2])
            cube([COUPON_WIDTH * 2.0, CHASSIS_SPINE_LENGTH * 0.48, LOCATING_LIP_HEIGHT + 4.0], center = true);

        // 3. Center screw through-hole & shallow test counterbore
        translate([SCREW_X, SCREW_Y, 0]) {
            translate([0, 0, -1.0])
                cylinder(r = SCREW_HOLE_DIAMETER / 2, h = total_coupon_h + 3.0);
            translate([0, 0, -1.0])
                cylinder(r = SCREW_COUNTERBORE_DIAMETER / 2, h = 2.0);
        }

        // 4. Embossed orientation indicator "FRONT"
        translate([0, (CHASSIS_SPINE_LENGTH / 2) - 12.0, COUPON_BASE_THICKNESS - 0.4])
            linear_extrude(height = 0.5)
                text("FRONT", size = 5.5, halign = "center", valign = "center", font = "Liberation Sans:style=Bold");
                
        // 5. Embossed label "PS5 FAT"
        translate([0, -(CHASSIS_SPINE_LENGTH / 2) + 12.0, COUPON_BASE_THICKNESS - 0.4])
            linear_extrude(height = 0.5)
                text("PS5 FAT", size = 5.0, halign = "center", valign = "center", font = "Liberation Sans:style=Bold");
    }
}


// ROOT RENDER DISPATCHER
if (MODE == "FIT_TEST") {
    fit_test_coupon();
} else if (MODE == "ALT_STAND") {
    production_vertical_stand();
} else {
    production_vertical_stand();
}
