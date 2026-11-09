// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
// International License (http://creativecommons.org/licenses/by-sa/4.0/)

use <Technic.scad/Technic.scad>

//#technic_beam( length = 11, height = 1);
$fn = 50;

technic_beam_hole_spacing = 8;
technic_height_in_mm = 7.8;
hole_wide = 11;
blade_width = 145;
blade_height = technic_beam_hole_spacing * 4;

translate([-technic_beam_hole_spacing * (hole_wide - 1) / 2, 0, 0]) {
    technic_beam( length = 5, height = 1, angles = [ -90, -90 ], vertices = [ 3, 4 ], axle_holes = [ ] );
    translate([technic_beam_hole_spacing * (hole_wide - 1), 0, 0])
        mirror([1, 0, 0])
            technic_beam( length = 5, height = 1, angles = [ -90, -90 ], vertices = [ 3, 4 ], axle_holes = [ ] );
}

difference() {
    intersection() {
        translate([-blade_width / 2, -blade_height + technic_beam_hole_spacing/2 - 0.3, technic_height_in_mm])
            cube([blade_width, blade_height, 20]);
        translate([blade_width/2 + 1, 0, blade_height + technic_height_in_mm - 3])
                rotate([0, -90, 0])
                    cylinder(h = blade_width + 2, d=blade_height * 2);        
    }
    translate([blade_width/2 + 1, 0, blade_height + technic_height_in_mm + 3])
        rotate([0, -90, 0])
            cylinder(h = blade_width + 2, d=blade_height * 2);
}
