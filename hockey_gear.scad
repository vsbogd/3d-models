use <publicDomainGearV1.1.scad>

$fn=100;
eps = 1;

internalCylinderDiameter = 7;
topCylinderDiameter = 5;

module t() {
    translate([1, -0.5, 9 + 22 + 3]) cube([1.5 + eps,1,7 + eps]);
}

difference() {

union() {
    
difference() {
    
    translate([0, 0, 9]) cylinder(d=topCylinderDiameter, h=22 + 10);
    
    t();
    mirror([1, 0, 0]) t();
}
translate([0, 0, 9 + 22]) cylinder(d1=5.5,d2=5,h=3);

translate([0, 0, 0]) cylinder(d=internalCylinderDiameter, h=8 + 1);

translate([0, 0, 4]) gear(
    mm_per_tooth = 3.5, 
    number_of_teeth=8, 
    thickness=8, 
    hole_diameter=0, 
    twist=-90, 
    teeth_to_hide = 0, 
    pressure_angle  = 28, 
    clearance       = 0.0, 
    backlash        = 0);
    
}

//translate([0, 0, -1.1]) cylinder(d1=5, d2=0, h=4);

}