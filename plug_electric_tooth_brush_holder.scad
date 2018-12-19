// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

$fn=100;

module roundcube(box) {
    cube(box, center=true);
    translate([-box.x/2, 0, 0]) cylinder(h=box.z, d=box.y, center=true);
    translate([box.x/2, 0, 0]) cylinder(h=box.z, d=box.y, center=true);
}

module pin() {
    union() {
        cylinder(h=8.5, d=4.5);
        translate([0, 0, 8.5]) {
            cylinder(h=7, d=5);
        }
        translate([0, 0, 15.5]) sphere(2.55, center=true);
    }
}

 
rotate([0, 90, 0]) {
pin();

translate([16, 0, 0]) {
    pin();
}

translate([-9, -7, -15]) {
    cube([35, 14, 15]);
}

 translate([0, -20, -11]) {
    rotate(a=[0,90,0]) {
        roundcube([3.5, 5, 20]);
    }
}

translate([9, -23, -15]) {
        cube([17, 17, 8]);
}

translate([0, 3, -30]) {
    rotate(a=[0,90,0]) {
        roundcube([3.5, 5, 20]);
    }
}

translate([9, 7, -34]) {
    rotate(a=[90,0,0]) {
        cube([17, 27, 8]);
    }
}

}