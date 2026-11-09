// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
// International License (http://creativecommons.org/licenses/by-sa/4.0/)

$fn=50;

center_tube_len=20;

module small_shaft_center() {
    translate([17, 0, 0]) children();
}

module vertical() {
    translate([0, 0, -32 + 14]) cylinder(h=32, d=4.3);
    translate([0, 0, -21 + 14 - 5.5]) cylinder(h=21, d=7);

    small_shaft_center() {
        cylinder(h=12, d=3.3);
        cylinder(h=9, d=5);
    }

    translate([0, 0, -2 + 0.0001]) linear_extrude(2) hull() {
        circle(d=7);
        small_shaft_center() circle(d=5);
    }
}

module axis_tube_center() {
    translate([0, -8 + 8/2, -center_tube_len + 7/2]) children();
}

module horizontal() {
    translate([0, 0, -2 + 1]) linear_extrude(2) polygon([[19, -2], [17, 0], [0, 3], [0, -12]]);
    axis_tube_center() cylinder(h=center_tube_len, d=8);    
}

module axis() {
    translate([0, 0, -0.001]) axis_tube_center() cylinder(h=center_tube_len + 0.002, d=4);
}

module support() {
    rotate([-90, 180, 270]) difference() {
        union() {
            rotate([-90, 0, 0]) vertical();
            horizontal();
        }
        axis();
    }
}

support();
translate([20, 0, 0]) mirror([1, 0, 0]) support();
