// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
// International License (http://creativecommons.org/licenses/by-sa/4.0/)

KnobDiameter = 37;
KnobHeight = 15.5;
KnobWall = 1.5;

HoleDiameter = 6.2;
HoleFlatThickness = 0.4;
HoleWall = 1.5;
HoleDepth = 14.4;
ShaftExtraLength = 1; // can be negative
SplitShaft = 0;

Pointer = 1;
PointerMarksCount = 5;
PointerMarksStartDegrees = 0;
PointerMarksClockwise = 1;

module __customizer_limit__() {}

$fn=50;

module knob() {
    difference() {
        cylinder(h=KnobHeight, d=KnobDiameter, center=true);
        
        translate([0, 0, - KnobWall - 0.001])
            cylinder(h=KnobHeight - KnobWall, d=KnobDiameter - 2 * KnobWall, center=true);
    }
}

module shaft() {
    Height = KnobHeight + ShaftExtraLength;
    translate([0, 0, -ShaftExtraLength/2])
        difference() {
            cylinder(h=Height, d=HoleDiameter + 2 * HoleWall, center=true);
            translate([0, 0, -(Height - HoleDepth)/2 - 0.001])
                union() {
                    difference() {
                        cylinder(h=HoleDepth, d=HoleDiameter, center=true);
                        translate([-HoleDiameter/2 + HoleFlatThickness/2, 0, 0])
                            cube([HoleFlatThickness, HoleDiameter + 0.001, HoleDepth + 0.001], center=true);
                    }
                    if(SplitShaft == 1) {
                        translate([HoleDiameter/2, 0, 0])
                            cube([HoleWall*2, HoleWall, HoleDepth], center=true);
                    }
                }
    }
}

module mark(size) {
    translate([KnobDiameter*2/6 - KnobWall, 0, KnobHeight/2 + 0.001])
        cube([KnobDiameter/6 * size, KnobWall, KnobWall/2], center=true);
}

module pointer() {
    marks_count = max(1, PointerMarksCount);
    size_step = 1.0 / marks_count;
    direction = PointerMarksClockwise * 2 - 1;
    for (i = [0:marks_count-1]) {
        rotate([0, 0, -PointerMarksStartDegrees + direction * 25 * i]) mark(1.0 - size_step * i);
    }
}

difference() {
    union() {
        knob();
        shaft();
    }
    if (Pointer == 1) pointer();
}


