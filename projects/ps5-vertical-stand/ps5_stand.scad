// =============================================================================
// PS5 Fat Disc Edition Vertical Stand — V4 Production Candidate
// Target: Original/Fat PS5 Disc Edition, CFI-1000 family
// Basis: V3 local mounting interface PHYSICALLY PASSED by user on 2026-08-29.
// Material: PETG
// =============================================================================

/* [Render Selection] */
MODE = "OEM_STAND"; // [FIT_TEST, OEM_STAND, REPLACEMENT_STAND]

/* [External reference / classification] */
SONY_REFERENCE_FOOTPRINT = 155.0; // VERIFIED reference from Sony CFI-ZVS1 docs
BASE_DIAMETER = 160.0;            // INFERRED: +5 mm over Sony reference
BASE_THICKNESS = 10.0;            // INFERRED: structural base while preserving fastener reach
EDGE_CHAMFER = 1.2;               // INFERRED print/handling chamfer

/* [Physically verified V3 interface — DO NOT CHANGE without new fit test] */
V3_GAUGE_OUTER_DIAMETER = 48.0;
CONTACT_PCD = 30.0;
CONTACT_PAD_DIAMETER = 8.0;
CONTACT_PAD_HEIGHT = 0.8;
CENTER_BORE_DIAMETER = 5.0;        // clearance/sight bore only; no thread claim

/* [Fastener seat] */
// iFixit verifies only the original captive stand screw's total length (26.5 mm).
// Thread diameter/pitch is intentionally NOT encoded as a claim here.
// ZedLabz describes its aftermarket captive replacement as matching the original
// PS5 stand screw for CFI-1000/1100/1200, so both variants currently share this
// conservative envelope. Measure a purchased screw before narrowing these values.
OEM_COUNTERBORE_DIAMETER = 16.0;
OEM_COUNTERBORE_DEPTH = 4.0;
REPLACEMENT_COUNTERBORE_DIAMETER = 16.0;
REPLACEMENT_COUNTERBORE_DEPTH = 4.0;

/* [Feet] */
FOOT_DIAMETER = 11.0;
FOOT_DEPTH = 1.0;
FOOT_PCD = 124.0;

/* [Mesh] */
$fn = $preview ? 64 : 160;

module v3_contact_pads(z0) {
    for (a = [90, 210, 330]) {
        rotate([0,0,a])
            translate([CONTACT_PCD/2, 0, z0])
                cylinder(d=CONTACT_PAD_DIAMETER, h=CONTACT_PAD_HEIGHT);
    }
}

module base_solid() {
    union() {
        cylinder(d=BASE_DIAMETER - 2*EDGE_CHAMFER, h=BASE_THICKNESS);
        cylinder(d1=BASE_DIAMETER, d2=BASE_DIAMETER - 2*EDGE_CHAMFER,
                 h=EDGE_CHAMFER);
    }
}

module foot_recesses() {
    for (a = [45,135,225,315]) {
        rotate([0,0,a])
            translate([FOOT_PCD/2,0,-0.01])
                cylinder(d=FOOT_DIAMETER, h=FOOT_DEPTH+0.02);
    }
}

module fastener_cut(counterbore_d, counterbore_depth) {
    translate([0,0,-1])
        cylinder(d=CENTER_BORE_DIAMETER, h=BASE_THICKNESS+CONTACT_PAD_HEIGHT+2);
    translate([0,0,-0.01])
        cylinder(d=counterbore_d, h=counterbore_depth+0.01);
}

module production_stand(counterbore_d, counterbore_depth) {
    difference() {
        union() {
            base_solid();
            v3_contact_pads(BASE_THICKNESS);
        }
        fastener_cut(counterbore_d, counterbore_depth);
        foot_recesses();
    }
}

module v3_fit_test() {
    GAUGE_THICKNESS = 4.0;
    difference() {
        union() {
            cylinder(d=V3_GAUGE_OUTER_DIAMETER, h=GAUGE_THICKNESS);
            v3_contact_pads(GAUGE_THICKNESS);
        }
        translate([0,0,-1])
            cylinder(d=CENTER_BORE_DIAMETER, h=GAUGE_THICKNESS+CONTACT_PAD_HEIGHT+2);
        translate([0,0,-0.01])
            cylinder(d=16.0, h=2.01);
    }
}

if (MODE == "FIT_TEST") {
    v3_fit_test();
} else if (MODE == "OEM_STAND") {
    production_stand(OEM_COUNTERBORE_DIAMETER, OEM_COUNTERBORE_DEPTH);
} else if (MODE == "REPLACEMENT_STAND") {
    production_stand(REPLACEMENT_COUNTERBORE_DIAMETER, REPLACEMENT_COUNTERBORE_DEPTH);
} else {
    assert(false, "Unknown MODE");
}
