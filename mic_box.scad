// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

$fn = 50;
eps = 0.01;

mic_diameter = 11;
mic_height = 9;
cable_diameter = 4;
wall_thickness = 1;

module trap(w, d1, d2, h) {
    delta = (d1 - d2)/2;
    echo("w, ", w, "d1", d1, "d2", d2, "h", h);
    polyhedron(points = [[0, 0, 0], [w, 0, 0], [w, d1, 0], [0, d1, 0], 
    [0, delta, h], [w, delta, h], [w, delta + d2, h], [0, delta + d2, h]],
    faces = [ [0,1,2,3], [4,5,1,0], [7,6,5,4], [5,6,2,1], [6,7,3,2], [7,4,0,3] ]);
}
module mic_box(h, d, w, l, w2) {
    if (w2 == undef) {
        mic_box_int(h, d, w, l, w);
    } else {
        mic_box_int(h, d, w, l, w2);
    }
}

module mic_box_int(h, d, w, l, w2) {
    echo("w", w, "w2", w2);
    union() {
        cylinder(d = d, h = h);
        translate([0, -w/2, w/2]) trap(l + d/2, d1 = w, d2 = w2, h = h - w/2);
        translate([0, 0, w/2]) rotate([0, 90, 0]) cylinder(d = w, h = l + d/2);
    }
}

module mic_box_(h, d, w, l, w2) {
    echo("w", w, "w2", w2);
    difference() {
        translate([d/2, -w/2, w/2]) trap(l, d1 = w, d2 = w2, h = h - w/2);
        translate([d/2 - eps, 0, w/2]) rotate([0, 90, 0]) cylinder(d = w + eps, h = l + 2 * eps);
    }
}

translate([0, 20, 0]) 
difference() {
    mic_box(h = mic_height + wall_thickness, d = mic_diameter + 2 * wall_thickness, l = mic_diameter * 1.5, w = cable_diameter + 2 * wall_thickness);
    translate([0, 0, wall_thickness]) mic_box(h = mic_height + eps, d = mic_diameter, l = mic_diameter * 1.5 + wall_thickness + eps, w = cable_diameter, w2 = cable_diameter - 1);
}

mirror([0, 0, 1])
translate([0, 0, wall_thickness]) 
mic_box_(h = mic_height, d = mic_diameter + 2 * wall_thickness, l = mic_diameter * 1.5, w = cable_diameter - 0.4, w2 = cable_diameter - 1- 0.4);