// =============================================================================
// PS5 Fat Disc Edition Vertical Stand — Recovery V3
// Target: Original/Fat PS5 Disc Edition, CFI-1000 family
// Status: CALIBRATION-FIRST. Production stand intentionally blocked until fit test.
// Material: PETG
// =============================================================================

/* [Render Selection] */
MODE = "FIT_TEST"; // [FIT_TEST, INTERFACE_GAUGE]

/* [Verified external reference] */
SONY_REFERENCE_FOOTPRINT = 155.0; // mm — reference only, not used by coupon

/* [V3 mounting-interface gauge] */
// The V3 coupon deliberately avoids pretending we know the PS5 underside contour.
// It tests only the region around the factory stand mounting point.
GAUGE_OUTER_DIAMETER = 48.0;       // INFERRED: intentionally compact
GAUGE_THICKNESS = 4.0;             // INFERRED: stiff enough for handling
CENTER_BORE_DIAMETER = 5.0;        // INFERRED clearance-only sight bore; no thread claim
COUNTERBORE_DIAMETER = 16.0;       // REFERENCE envelope for stand-screw head clearance
COUNTERBORE_DEPTH = 2.0;           // INFERRED; visual/fit test only

// Three raised contact pads create a deterministic tripod instead of a guessed full contour.
// If all three touch, the local mounting region is sufficiently planar for a later interface.
CONTACT_PCD = 30.0;                 // INFERRED pitch circle diameter
CONTACT_PAD_DIAMETER = 8.0;        // INFERRED
CONTACT_PAD_HEIGHT = 0.8;           // INFERRED; easy to revise from physical evidence

// Windows make it easy to inspect whether the gauge is touching nearby PS5 plastic.
WINDOW_WIDTH = 10.0;
WINDOW_LENGTH = 13.0;

/* [Mesh Resolution] */
$fn = $preview ? 72 : 144;

module rounded_window() {
    hull() {
        translate([0, -(WINDOW_LENGTH-WINDOW_WIDTH)/2]) circle(d=WINDOW_WIDTH);
        translate([0,  (WINDOW_LENGTH-WINDOW_WIDTH)/2]) circle(d=WINDOW_WIDTH);
    }
}

module v3_fit_test() {
    difference() {
        union() {
            // Main flat calibration disk.
            cylinder(d=GAUGE_OUTER_DIAMETER, h=GAUGE_THICKNESS);

            // Three tiny raised pads: minimum-contact tripod.
            for (a = [90, 210, 330]) {
                rotate([0,0,a])
                    translate([CONTACT_PCD/2, 0, GAUGE_THICKNESS])
                        cylinder(d=CONTACT_PAD_DIAMETER, h=CONTACT_PAD_HEIGHT);
            }
        }

        // Deliberately oversized sight/clearance bore around factory mounting axis.
        translate([0,0,-1])
            cylinder(d=CENTER_BORE_DIAMETER, h=GAUGE_THICKNESS+CONTACT_PAD_HEIGHT+2);

        // Shallow underside counterbore so a screw head can be checked later without
        // claiming this coupon is a structural fastener seat.
        translate([0,0,-0.01])
            cylinder(d=COUNTERBORE_DIAMETER, h=COUNTERBORE_DEPTH+0.01);

        // Three inspection windows between the contact pads.
        for (a = [30, 150, 270]) {
            rotate([0,0,a])
                translate([GAUGE_OUTER_DIAMETER*0.28,0,-1])
                    linear_extrude(height=GAUGE_THICKNESS+2)
                        rounded_window();
        }
    }
}

// INTERFACE_GAUGE is currently identical to FIT_TEST so the source has an explicit
// semantic name for future evolution without inventing a production stand early.
if (MODE == "FIT_TEST" || MODE == "INTERFACE_GAUGE") {
    v3_fit_test();
} else {
    assert(false, "Recovery V3 intentionally has no production STAND mode until the physical fit test passes.");
}
