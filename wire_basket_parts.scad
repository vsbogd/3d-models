// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

use <lib/common.scad>;

$fn = 50;

extdiam = 6;
intdiam = 4;
length = 10;
thin = (extdiam - intdiam);

module segment(height=length, diam=intdiam+0.4) {
    difference() {
        cube([extdiam, extdiam, height]);
        translate([extdiam/2, extdiam/2, -1]) cylinder(d=diam, h=height + 2);
    }
}

module corner() {
        diam=intdiam+0.2;
        translate([0, 0, extdiam]) segment(diam=diam);
        translate([0, extdiam, extdiam]) rotate([-90, 0, 0]) segment(diam=diam);
        translate([extdiam, 0, extdiam]) rotate([0, 90, 0]) segment(diam=diam);
        
        cube([extdiam, extdiam, extdiam + 1]);
        cube([extdiam + 1, extdiam, extdiam]);
        cube([extdiam, extdiam + 1, extdiam]);
}

module crossed() {
    difference() {
        cube([extdiam, extdiam, extdiam*2 - thin]);
        translate([intdiam/2 + thin/2, extdiam + 1, intdiam/2 + thin/2]) rotate([90, 0, 0]) cylinder(d=intdiam, h=extdiam + 2);
        translate([-1, intdiam/2 + thin/2, extdiam+thin/2]) rotate([0, 90, 0]) cylinder(d=intdiam, h=extdiam + 2);
    }
}

module ttop() {
    translate([0, 2*length+extdiam, 0]) rotate([90, 0, 0]) segment(2*length + extdiam);
    translate([0, length, extdiam]) segment();
}

module ttop2() {
    translate([0, 2*length+extdiam, 0]) rotate([90, 0, 0]) segment(2*length + extdiam);
    translate([extdiam - thin, length, extdiam]) segment();
    translate([extdiam, length, 0]) cube([extdiam - thin, extdiam, extdiam]);
}

module tside() {
    translate([extdiam, 0, extdiam]) rotate([-90, 0, 0]) segment(2*length+extdiam);
    translate([thin, length, extdiam]) segment();
    translate([thin, length, 0]) cube([extdiam-thin, extdiam, extdiam]);
    translate([2*extdiam, length, extdiam]) rotate([0, 90, 0]) segment();    
}


corner();
translate([20, 0, 0]) ttop();
translate([40, 0, 0]) ttop2();
translate([60, 0, 0]) tside();
translate([-20, 0, 0]) crossed();
