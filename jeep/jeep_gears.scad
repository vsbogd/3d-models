// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
// International License (http://creativecommons.org/licenses/by-sa/4.0/)

include <BOSL/constants.scad>
use <BOSL/involute_gears.scad>

$fn = 50;

function modul(outer_diam, teeth_num) = outer_diam/(teeth_num + 2);
function pitch_diam(outer_diam, teeth_num) = teeth_num * modul(outer_diam, teeth_num);
function mm_per_tooth(outer_diam, teeth_num) = PI * pitch_diam(outer_diam, teeth_num) / teeth_num;

module axis() {
    axis_diam = 4;
    teeth = 42;

    difference() {
        union() {
            gear(mm_per_tooth(26.5, teeth), teeth, 3.6, axis_diam, align=V_ABOVE);
            translate([0, 0, -6]) cylinder(h=12.7, d=7);
        }
        cylinder(h=40, d=axis_diam, center=true);
    }
}

module reductor() {
    eps = 0.01;
    axis_diam = 2 + 0.1;
    teeth_big = 30;
    thick_big = 2.8;
    teeth_small = 10;
    difference() {
        union() {
            gear(mm_per_tooth(19, teeth_big), teeth_big, thick_big, axis_diam, align=V_ABOVE);
            translate([0, 0, thick_big - eps]) gear(mm_per_tooth(7, teeth_small), teeth_small, 5 + eps, axis_diam, align=V_ABOVE);
            translate([0, 0, -2]) cylinder(h=12.3, d=4.3);
        }
        cylinder(h=40, d=axis_diam, center=true);
    }
}

module main() {
    eps = 0.01;
    axis_diam = 2;
    teeth = 8;

    difference() {
        union() {
            gear(mm_per_tooth(6, teeth), teeth, 6, axis_diam, align=V_ABOVE);
            translate([0, 0, 6-eps]) cylinder(h=1, d=6);
        }
        cylinder(h=40, d=axis_diam, center=true);
    }
}


rotate([180, 0, 0]) axis();
translate([30, 0, 0]) reductor();
translate([-30, 0, 0]) rotate([180, 0, 0]) main();

for (d = [2:2:4]) {
    y = d * 10;
    for (i = [0:1:6]) {
        delta = (i - 1) * 0.1;
        diam = d + delta;
        echo(delta);
        x = 10 * i;
        translate([x, y, 0]) difference() {
            cylinder(d=diam*2, h=5, center=true);
            cylinder(d=diam, h=6, center=true);
        }
    }
}