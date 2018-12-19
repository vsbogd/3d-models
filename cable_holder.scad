// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

use <lib/common.scad>;

$fn=100;
width=10;
height=16;
thickness=6.4;
hole_diameter=4;
screw=(height-2-hole_diameter)/2;

rotate([0, -90, 0]) difference() {


difference() {
    translate([0, 0, -thickness]) rotate([90, 0, 90]) round_cube(dimensions=[height, thickness*2, width], radius=4);
    translate([-1, -1, -thickness-1]) cube([width + 2, height + 2, thickness + 1]);
}

translate([width/2, screw, 0]) screw_hole(screwDiameter=4, headDiameter=7, depth=thickness, headDepth=2);

translate([-1, height-2-hole_diameter/2, hole_diameter/2]) rotate([90, 0, 90]) union() {
        cylinder(d=hole_diameter, h=width + 2);
        translate([-hole_diameter/2, -hole_diameter, 0]) cube([hole_diameter, hole_diameter, width + 2]);
    }
}
