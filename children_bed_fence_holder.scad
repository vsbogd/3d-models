// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

use <lib/common.scad>;

$fn=100;
rxd = 20;
lxd = 20;

zd = 25; // height

ryd = 30;
lyd = 32;
yd = max(lyd, ryd);

thikness = 2;
screw = 3;

module cube_hole(dimensions, diameter) {
    difference() {
        cube(dimensions);
        
        translate([dimensions[0] / 2, dimensions[1] / 2, 0]) 
        translate([0, 0, dimensions[2]]) mirror([0, 0, 1]) screw_hole(screw, screw + 4, dimensions[2], 0.6);
        
        translate([dimensions[0] / 2, dimensions[1] / 2, 0]) screw_hole(screw, screw + 4, dimensions[2], 0.5);
    }
}

e=1;

translate([0, 0, thikness]) rotate([90, 0, 0]) union() {

// divider
translate([-e - yd/2, -e, 0]) cube_hole([yd + 2*e, zd + 1*e, thikness]);

// left part: support
translate([-lyd/2, 0, 0]) union() {
    translate([-thikness, -e, lxd + thikness]) rotate([0, 90, 0]) cube([lxd + thikness, zd + e, thikness]);
    translate([lyd, -e, lxd + thikness]) rotate([0, 90, 0]) cube([lxd + thikness, zd + e, thikness]);
    translate([-thikness, 0, 0]) rotate([90, 0, 0]) cube([lyd + 2 * thikness, lxd + thikness, thikness]);
}

// right part
translate([-ryd/2, 0, 0]) union() {
    translate([ryd, -thikness, e]) rotate([0, 90, 0]) cube([rxd + e, zd + thikness, thikness]);
    translate([-thikness, -thikness, e]) rotate([0, 90, 0]) cube([rxd + e, zd + thikness, thikness]);
}

}