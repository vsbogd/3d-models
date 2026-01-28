// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

bit_height = 21;
bit_width = 22;
bit_thickness = 4.5;
post_diameter = 5.1;
wall_thickness = 1;
bottom_border = 1;

module __customizer_limit__() {}

$fn = 50;

difference() {
    union() {
        translate([0, 0, wall_thickness/2])
            round_cube([bit_width + 2*wall_thickness + 2*bottom_border, bit_thickness +
            2*wall_thickness + 2*bottom_border, wall_thickness], radius=2, center=true);
        translate([0, 0, wall_thickness + (bit_height + wall_thickness) / 2 - 0.001])
            difference() {
                union() {
                    round_cube([bit_width + 2*wall_thickness, bit_thickness + 2*wall_thickness,
                        bit_height + wall_thickness], radius=2, center=true);
                    cylinder(d=post_diameter + 2 * wall_thickness, h=bit_height + wall_thickness, center=true);
                }
                cube([bit_width, bit_thickness, bit_height + wall_thickness + 0.001], center=true);
            }
    }
    cylinder(h=3*bit_height, d=post_diameter, center= true);
}

module center(dims) { translate([-dims[0]/2, -dims[1]/2, -dims[2]/2]) children(); }

module _center_by_flag(dimensions, center) {
    if (center) {
        center(dimensions) children();
    } else {
        children();
    }
}

module round_cube(dimensions, radius, center=false) {
    width = dimensions[0];
    depth = dimensions[1];
    height = dimensions[2];
    assert(radius < width/2, "radius should be less than half of x size");
    assert(radius < depth/2, "radius should be less than half of y size")
    _center_by_flag(dimensions, center)
        translate([radius, radius, 0]) 
            linear_extrude(height=height) 
                minkowski() {
                    square([width - radius*2, depth - radius*2]);
                    circle(r=radius);
                }
}
