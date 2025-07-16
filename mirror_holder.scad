distance_to_wall = 2;           // distance between wall and back of the mirror
min_mirror_thickness = 3;       // minimum thickness of the mirror
max_mirror_thickness = 5;       // maximum thickness of the mirror
min_thread_length = 5;          // minimum length of the thread to hold the cap
cap_diameter = 30;              // diameter of the cap
cap_thickness = 2;              // thickness of the cap's walls
screw_diameter = 4;             // screw body diameter
screw_head_diameter = 8;        // screw head diameter
screw_chamfer = false;          // add screw chamfer

space_for_mirror_ratio = 0.3;   // the ratio of the base diameter reserved for the mirror
corner_ratio = 1.0;             // the ratio of the base diameter reserved to make a corner holder
                                // 0.5 - corner holder, half of the diameter holds the mirror
                                // 0.8 - corner holder, bigger part of the diameter holds the mirror
                                // 1.0 - side holder, no corner
no_support = 1.0;               // 1 - cut a bit to allow print without support, 0 - don't cut anything,
                                // can also be fractional




module __customizer_limit__() {}

assert(min_mirror_thickness < max_mirror_thickness);

// required libraries

use <rcolyer/threads.scad> // get at https://github.com/rcolyer/threads-scad/tree/master
include <NopSCADlib/utils/core/core.scad> // get at https://github.com/nophead/NopSCADlib/tree/v21.40.0

// common parameters

$fn = 100;
eps = 0.0001;

// thread parameters

pitch = 0;
tooth_angle = 30;
tolerance = 0.4;
tip_height = 0;
tooth_height = 2;

// precalculations

screw_body_length_min = distance_to_wall + max_mirror_thickness;
echo("minimum screw body lenght: ", screw_body_length_min);

thread_length = max_mirror_thickness + min_thread_length;
base_height = distance_to_wall + thread_length;
base_diameter = cap_diameter - 2 * cap_thickness;
base_radius = base_diameter / 2;
space_for_mirror = space_for_mirror_ratio * base_diameter;
cut_for_support = tooth_height * no_support;
thin_base_center = (base_diameter - space_for_mirror - cut_for_support) / 2;
assert(thin_base_center > screw_diameter/2 + 1);
screw_hole_x = -base_radius + cut_for_support + thin_base_center;
screw_head_height = min_thread_length;

cap_thread_depth = (max_mirror_thickness - min_mirror_thickness) + min_thread_length;
cap_depth = cap_thread_depth + cap_thickness;

// modules

module base() {
    screw_hole(screw_diameter, screw_head_diameter, base_height, screw_head_height, [screw_hole_x, 0, 0])
        difference() {
            union() {
                cylinder(h = distance_to_wall, d = base_diameter);
                zmove(distance_to_wall - eps)
                    difference() {
                        ScrewThread(base_diameter, thread_length + eps, pitch, tooth_angle, tolerance, tip_height, tooth_height, tip_min_fract=0);
                        zmove(-eps) xmove(base_radius - space_for_mirror)
                            ymove(-base_diameter * corner_ratio  + eps) ymove(base_radius)
                                cube([space_for_mirror + eps, base_diameter + 2*eps, max_mirror_thickness + eps]);
                    }
            }
            // tooth_height instead of eps here, because thread size is bigger than tooth_height
            // and some artifacts are left if eps is used
            xmove(-base_radius - tooth_height) zmove(-eps) ymove(-base_radius) cube([cut_for_support + tooth_height, base_diameter, base_height + 2*eps]);
        }
}

module cap() {
    ScrewHole(base_diameter, cap_thread_depth, [0,0,0], [0,0,0], pitch, tooth_angle, tolerance, tooth_height)
        cylinder(h = cap_depth, d = cap_diameter);
}

xmove(-base_radius - 5)
    zmove(base_radius - cut_for_support) rotate([0, -90, 0]) base();
xmove(cap_diameter/2 + 5)
    zmove(cap_depth) rotate([180, 0, 0]) cap();

// common modules

module xmove(dist) { translate([dist, 0, 0]) children(); }
module ymove(dist) { translate([0, dist, 0]) children(); }
module zmove(dist) { translate([0, 0, dist]) children(); }
module center(dims) { translate([-dims[0]/2, -dims[1]/2, -dims[2]/2]) children(); }

module screw_hole(screwDiameter, headDiameter, fullHeight, headHeight, position) {
    headZ = fullHeight - headHeight;
    chamfer_size = screw_head_diameter/2 * (screw_chamfer ? 1 : 0);
    difference() {
        children();
        translate(position)
            zmove(headZ) rotate([180, 0, 90])
                union() {
                    zmove(-eps) teardrop(h=headZ + 2*eps, r=screw_diameter/2, center = false, truncate = false, chamfer = chamfer_size, chamfer_both_ends = false, plus = false);
                    zmove(-headHeight-eps) teardrop(h=headHeight + eps, r=headDiameter/2, center = false, truncate = false, chamfer = 0, chamfer_both_ends = false, plus = false);
        }
    }
}
