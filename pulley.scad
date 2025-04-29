// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

diameter = 25;
height = 8;
hole = 5;
groove_height = 6;
groove_depth = 6;

module __customizer_limit__() {}

$fn=100;

groove_radius = groove_height / 2;
groove_scale = groove_depth / groove_radius;
groove_pos = diameter / 2;

difference() {
    cylinder(d=diameter, h=height, center=true);
    rotate_extrude() translate([groove_pos, 0, 0]) scale([groove_scale, 1]) circle(r = groove_radius);
    translate([0, 0, 0]) cylinder(d=hole, h=height + 2, center=true);
}