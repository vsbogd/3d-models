// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

$fn=100;

/*
difference() {
    union() {
        cylinder(d=25, h=1);
        translate([0, 0, 1]) cylinder(d1=10, d2=15, h=8);
        translate([0, 0, 9]) cylinder(d=8.8, h=1.2);
    }
    translate([0, 0, -1]) cylinder(d=5.2, h=40);
}

translate([30, 0, 0]) difference() {
    cylinder(d=25, h=1);
    translate([0, 0, -1]) cylinder(d=9.5, h=3);
}

difference() {
    union() {
        cylinder(d=25, h=1);
        translate([0, 0, 1]) cylinder(d1=25, d2=15, h=4);
        translate([0, 0, 5]) cylinder(d1=15, d2=25, h=4);
        translate([0, 0, 9]) cylinder(d=25, h=1);
    }
    translate([0, 0, -1]) cylinder(d=5, h=12);
}
*/

difference() {
    cylinder(d=25, h=8, center=true);
    rotate_extrude() translate([13, 0, 0]) scale([2, 1]) circle(r = 3);
    translate([0, 0, 0]) cylinder(d=5, h=12, center=true);
}