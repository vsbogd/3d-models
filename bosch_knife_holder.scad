// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

width=60;
length=55;
height=20;
thickness=3;

diskThickness=0.8;
instrumentThickness=2;
instrumentDiameter=140;
diskDiameter=160;
diskBorder=8;

module knife() {
    union() {
        cylinder(d=diskDiameter-diskBorder, h=diskThickness+0.1);
        translate([0, 0, diskThickness]) cylinder(d=diskDiameter, h=diskThickness);
        translate([0, 0, 2*diskThickness-0.1]) cylinder(d=instrumentDiameter, h=instrumentThickness+0.1);
        translate([0, 0, -instrumentThickness]) cylinder(d=instrumentDiameter, h=instrumentThickness+0.1);
    }
}

difference() {
    
    union() {
        translate([0, 0, 20]) cube([width, length, thickness]);
        cube([thickness, length, height]);
        translate([width - thickness, 0, 0]) cube([thickness, length, height]);
    }
    
    for (y = [10:10:length]) {
        translate([width/2, y, 85]) rotate([88, 0, 0]) #knife();
    }
}

