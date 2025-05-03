// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

width=10;
length=16;
height=6.4;
wireDiameter=4;
screwDiameter = 4;
screwHeadDiameter = 7;
screwHeadHeight = 2;

module __customizer_limit__() {}

// Library functions

use <common.scad>;

// Model

$fn=100;
centerX=length/2;
screwX=(length-2-wireDiameter)/2;

module body() {
    eps = 0.01;
    difference() {
        round_cube(dimensions=[length, height*2, width], radius=4, center=true);
        translate([0, -(height + eps)/2, 0]) cube([length + 2*eps, height + eps, width + 2*eps], center=true);
    }
}

module wire() {
    eps = 0.01;
    union() {
        cylinder(d=wireDiameter, h=width + 2*eps, center=true);
        translate([0, -wireDiameter/2, 0])
            cube([wireDiameter, wireDiameter, width + 2*eps], center=true);
    }
}

module screw() {
    rotate([-90, 0, 0])
        screw_hole(screwDiameter=screwDiameter, headDiameter=screwHeadDiameter, fullHeight=height, headHeight=screwHeadHeight);
}

difference() {
    body();
    translate([centerX - wireDiameter/2 - 2, wireDiameter/2, 0]) wire();
    translate([-centerX + screwX, 0, 0]) screw();
}
