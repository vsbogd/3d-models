use <lib/common.scad>;
$fn=25;
diameter = 23.5 + 0.5;

thickness = 2;
hole_diameter = 4.5;
hole_distance = 10;
edge_distance = hole_diameter / 2;
corner_radius = 1;

external_diameter = diameter + 2 * thickness;
hd = ceil((external_diameter + hole_diameter) / hole_distance) * hole_distance;
echo("distance between holes: ", hd);

base_x_size = hd + hole_diameter + edge_distance * 2;
base_y_size = hole_diameter + edge_distance * 2;

rotate([90, 0, 0]) {

difference() {
    round_cube([base_x_size, base_y_size, thickness], corner_radius, true);
    translate([-hd/2, 0, 0]) cylinder(d=hole_diameter, h=thickness + 1, center=true);
    translate([hd/2, 0, 0]) cylinder(d=hole_diameter, h=thickness + 1, center=true);
}

holder_x_size = external_diameter;
holder_y_size = external_diameter;

translate([0, 0, holder_x_size / 2]) rotate([90, 0, 0]) difference() {
    round_cube([holder_x_size, holder_y_size, base_y_size], corner_radius, true);
    cylinder(d=diameter, h=base_y_size + 1, center=true);
}
}