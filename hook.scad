// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

use <common.scad>;

width=20;
height=50;
thickness=3;
firstScrewFromTop=7;
distanceBetweenScrews=18;
hookDiameter=20;
$fn=100;

module hook() {
    intersection() {
        hollow_cylinder(height=width, externalDiameter=hookDiameter, internalDiameter=hookDiameter - 2 * thickness);
        translate([0, -hookDiameter/2, 0]) cube([hookDiameter/2, hookDiameter, width]);
    }
}

module screw() {
    screw_hole(screwDiameter=4, headDiameter=7, depth=thickness, headDepth=1);
}

module rounding() {
    intersection() {
        round_cube([thickness*2 + 1, width, thickness], thickness);
        cube([thickness, width, thickness]);
    }
}

rotate([90, 0, 0]) difference() {
    union() {
        translate([0, 0, 0]) 
            rounding();
        translate([thickness, 0, 0]) 
            cube([height-thickness-hookDiameter/2, width, thickness], 3);
        translate([height - hookDiameter / 2, 0, hookDiameter / 2]) rotate([-90, 0, 0]) 
            hook();
        translate([height-thickness-hookDiameter/2, 0, hookDiameter-thickness]) 
            rounding();
    }

    translate([firstScrewFromTop, width/2, 0]) screw();
    translate([firstScrewFromTop + distanceBetweenScrews, width/2, 0]) screw();
}
