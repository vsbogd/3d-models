// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

module xmove(dist) { translate([dist, 0, 0]) children(); }
module ymove(dist) { translate([0, dist, 0]) children(); }
module zmove(dist) { translate([0, 0, dist]) children(); }
module xrot(angle) { rotate([angle, 0, 0]) children(); }
module yrot(angle) { rotate([0, angle, 0]) children(); }
module zrot(angle) { rotate([0, 0, angle]) children(); }

module round_cube(dimensions, radius, center=false) {
    if (center) {
        translate([0, 0, -0.5]) _round_cube(dimensions, radius, center);
    } else {
        translate([radius, radius, 0]) _round_cube(dimensions, radius);
    }
}

module _round_cube(dimensions, radius, center=false) {
        minkowski() {
            cube([dimensions[0] - radius*2, dimensions[1] - radius*2, dimensions[2] - 1], center=center);
            cylinder(r=radius,h=1);
        }
}


module hollow_cylinder_thick(height, outer_radius, thickness) {
    difference() {
        cylinder(h=height, r=outer_radius, center=true);
        cylinder(h=height + 0.02, r=outer_radius - thickness, center=true);
    }
}

module hollow_cylinder(height, externalDiameter, internalDiameter) {
    difference() {
        cylinder(height, r=externalDiameter/2);
        translate([0, 0, -1]) cylinder(height + 2, r=internalDiameter/2);
    }
}

module screw_hole(screwDiameter, headDiameter, depth, headDepth) {    
    translate([0, 0, -depth]) cylinder(h=4 * depth, r=screwDiameter / 2);
    translate([0, 0, depth - headDepth]) cylinder(h=4 * depth, r=headDiameter / 2);
}

module cylinder_sector(diameter, startAngle, endAngle) {
    cylinder(h=height, d=diameter);
}


$fn=100;
size=10;
distance=0;

round_cube(dimensions=[10,10,3], radius=3);
!round_cube(dimensions=[10,10,3], radius=3, center=true);
hollow_cylinder(height=3, externalDiameter=10, internalDiameter=7);
difference() { cube([10, 10, 3]); translate([5, 5, 0]) screw_hole(screwDiameter=3, headDiameter=6, depth=3, headDepth=1); }
cylinder_sector(height=3, diameter=10, startAngle=0, endAngle=180);