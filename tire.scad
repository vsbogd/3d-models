// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
// International License (http://creativecommons.org/licenses/by-sa/4.0/)

w = 15;
od = 70;
id = 55;
sw = 3;
sh = 2;
r = 2;
$fn = 50;

th = (od - id)/2;

module profile() {
    hull() {
        translate([0, r, 0]) square([w, th - r]);
        //translate([r, r, 0]) circle(r=r);
        square(r);
        translate([w - r, r, 0]) circle(r=r);
    }
    translate([0, th - 0.0001, 0]) square([sw, sh]);
}

rotate_extrude() translate([od/2, 0, 0]) rotate([0, 0, 90]) profile();
