// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
// International License (http://creativecommons.org/licenses/by-sa/4.0/)

use <Technic.scad/Technic.scad>
use <common.scad>
include <NopSCADlib/utils/core/core.scad>

$fn = 50;

technic_beam_hole_spacing = 8;
technic_height_in_mm = 7.8;
hole_wide = 11;

blade_width = 145;
blade_height = technic_beam_hole_spacing * 4;
blade_thick = 16;
side_width = 85;

bracket_thick = 2;
bracket_width = blade_width - 3 * bracket_thick;
bracket_height = technic_beam_hole_spacing * 2;
bracket_hole_diam = 4.4;

big_diam=39;

module blade() {
    blade_round_half_height = blade_height - bracket_height;
    union() {
        intersection() {
            ymove(big_diam/2) hollow_cylinder(height=blade_width, externalDiameter=big_diam, thickness=bracket_thick);
            cube([blade_round_half_height, blade_thick, blade_width]);
        }
        xmove(-bracket_height) cube([bracket_height, bracket_thick, blade_width]);
    }
}

module blade_minus() {
    union() {
        ymove(big_diam/2) cylinder(h=blade_width, d=big_diam);
        xmove(-bracket_height - 0.01) cube([bracket_height, big_diam, blade_width]);
    }
}

module side() {
    full_side_width = side_width + blade_thick;
    
    difference() {
        ymove(-side_width) xmove(-bracket_height) round_cube([blade_height, full_side_width, bracket_thick], 5);
        zmove(-0.01) blade_minus();
    }
}    

module blade_with_sides() {
    difference() {
        xmove(blade_width/2) zrot(-90) xrot(90) union() {
            blade();
            side();
            zmove(blade_width - bracket_thick) side();
        }
        holes();
    }
}

lego_beam_height = technic_beam_hole_spacing * 2;
module lego_beam() {
    side_lego_wholes_dist = technic_beam_hole_spacing * (hole_wide - 1);    
    ymove(-technic_beam_hole_spacing/2 + lego_beam_height)
        center([side_lego_wholes_dist, 0, 0]) 
            technic_beam( length = 5, height = 1, angles = [ -90, -90 ], vertices = [ 3, 4 ]);
}

module bracket() {
    difference() {
        union() {
            center([bracket_width, 0, 0]) cube([bracket_width, bracket_height, bracket_thick]);
            ymove(bracket_height - lego_beam_height) zmove(-technic_height_in_mm) union() {
                lego_beam();
                mirror([1, 0, 0]) lego_beam();
            }
        }
        holes();
    }
}

module holes() {
    module hole() {
        teardrop(h=bracket_thick + 2, r=bracket_hole_diam/2, truncate=false, center=false);
    }
    
    #ymove(bracket_height/2) zmove(-1) union() {
        xmove(10) hole();
        xmove(-10) hole();
        xmove(50) hole();
        xmove(-50) hole();
    }    
}

!blade_with_sides();
zmove(-bracket_thick) bracket();

#ymove(bracket_height - technic_beam_hole_spacing/2)
    zmove(-technic_height_in_mm-bracket_thick)
        center([hole_wide * technic_beam_hole_spacing, 0, 0])
            xmove(technic_beam_hole_spacing/2)
                technic_beam( length = hole_wide, height = 1);
