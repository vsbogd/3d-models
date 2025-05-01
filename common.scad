// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

module xmove(dist) { translate([dist, 0, 0]) children(); }
module ymove(dist) { translate([0, dist, 0]) children(); }
module zmove(dist) { translate([0, 0, dist]) children(); }
module xrot(angle) { rotate([angle, 0, 0]) children(); }
module yrot(angle) { rotate([0, angle, 0]) children(); }
module zrot(angle) { rotate([0, 0, angle]) children(); }
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

module hollow_cylinder(height, externalDiameter, internalDiameter, thickness, center=false) {
    assert(internalDiameter != undef || thickness != undef, "either internalDiameter or thickness should be passed");
    internalDiameter = internalDiameter == undef ? externalDiameter - 2*thickness : internalDiameter;
    _center_by_flag([0, 0, height], center)
        difference() {
            cylinder(height, d=externalDiameter);
            translate([0, 0, -1]) cylinder(height + 2, d=internalDiameter);
        }
}

module screw_hole(screwDiameter, headDiameter, fullHeight, headHeight) {    
    headZ = fullHeight - headHeight;
    union() {
        translate([0, 0, -0.01]) cylinder(h=fullHeight + 0.02, d=screwDiameter);
        translate([0, 0, headZ]) cylinder(h=headHeight + 0.01, d=headDiameter);
    }
}

module cylinder_sector(radius, height, startAngle, endAngle) {
    assert(startAngle >= 0 && startAngle <= 360, "startAngle should be between 0 and 360");
    assert(endAngle >= 0 && endAngle <= 360, "endAngle should be between 0 and 360");
    a = endAngle - startAngle;
    angle = a < 0 ? 360 + a : a;
    echo ("angle = ", angle);
    rotate([0, 0, startAngle]) rotate_extrude(angle=angle) square([radius, height]);
}


$fn=100;

//round_cube(dimensions=[10,10,3], radius=3);
//round_cube(dimensions=[10,10,3], radius=3, center=true);
//hollow_cylinder(height=3, externalDiameter=10, internalDiameter=7);
//hollow_cylinder(height=3, externalDiameter=10, internalDiameter=7, center=true);
//hollow_cylinder(height=3, externalDiameter=10, thickness = 1, center=true);
difference() { cube([10, 10, 3]); translate([5, 5, 0]) screw_hole(screwDiameter=3, headDiameter=6, fullHeight=3, headHeight=1); }
//cylinder_sector(height=3, radius=5, startAngle=60, endAngle=180);