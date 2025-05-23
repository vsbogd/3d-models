// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

ba=10;
bb=10;
bw=23;
bl = ba + bb;
bh=12;

al = 20;
aw = 7;
ah = 4.5;
ail = 8.4; // 8
aiw = 2.4; // 2

az = 1.5;

module a() {
    translate([al/2, aw/2, ah/2])
        difference() {
            cube([al, aw, ah], center = true);
            cube([ail, aiw, ah + 0.1], center = true);
        }
}

module b() {
    translate([0, bw, 0])
        rotate([90, 0, 0])
            linear_extrude(height = bw)
                polygon([ [0, 0], [ba, 0], [bl, bh], [0, bh] ]);
}

translate([0, bw, bh]) rotate([180, 0, 0]) union() {
    translate([0, 0, bh - ah - az]) a();
    translate([0, bw - aw, az]) a();
    translate([al, 0, 0]) b();
}
translate([-3, -3, 0]) cube([al + 5, bw + 6, 0.35]);