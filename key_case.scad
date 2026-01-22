$fn = 50;
bit_height = 21;
bit_width = 22;
bit_thickness = 4.5;
case_thick = 1;
case_border = 1;
post_diameter = 5.1;

use <common.scad>

difference() {
    union() {
        translate([0, 0, case_thick/2])
            round_cube([bit_width + 2*case_thick + 2*case_border, bit_thickness +
            2*case_thick + 2*case_border, case_thick], radius=2, center=true);
        translate([0, 0, case_thick + (bit_height + case_thick) / 2 - 0.001])
            difference() {
                round_cube([bit_width + 2*case_thick, bit_thickness + 2*case_thick,
                bit_height + case_thick], radius=2, center=true);
                cube([bit_width, bit_thickness, bit_height + case_thick + 0.001], center=true);
            }
    }
    cylinder(h=3*bit_height, d=post_diameter, center= true);
}
