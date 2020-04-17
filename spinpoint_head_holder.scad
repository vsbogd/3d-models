use <lib/common.scad>

platter_height = 2.2;
platter_radius = 60;
x_size = platter_radius + 30;
z_size = 5;
y_size = 15;
top_platter_z = 6.3;
bottom_platter_z = 2;
support_height = 0.3; // 0.41
support_length = 10;

rotate([90, 0, 0]) {

difference() {
    translate([0, z_size, 0]) rotate([90, 0, 0]) round_cube([x_size, y_size, z_size], 1, false);
    
    translate([-1, -1, bottom_platter_z]) cube([platter_radius, y_size + 2, platter_height]);
    translate([-1, -1, top_platter_z]) cube([platter_radius, y_size + 2, platter_height]);
    
    translate([-1, -1, top_platter_z + platter_height + support_height]) {
        cube([support_length, y_size + 2,  y_size]);
    }
    translate([-1, -1, bottom_platter_z + platter_height + support_height]) {
        cube([support_length, y_size + 2, top_platter_z - bottom_platter_z - platter_height - 2 * support_height]);
    }
    translate([-1, -1, -0.1]) {
        cube([support_length, y_size + 2, bottom_platter_z - /* 2 * */ support_height + 0.1]);
    }
}

}