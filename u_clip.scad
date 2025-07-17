// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (http://creativecommons.org/licenses/by-sa/4.0/)

thickness = 4;
inner_width_begin = 50;
inner_width_end = 45;
depth = 40;
height = 60;

module __customizer_limit__() {}

thickness_delta = (inner_width_begin - inner_width_end) / 2;
linear_extrude(height=height) polygon(points=
    [
        [0, 0], [depth, thickness_delta], [depth, -thickness], [-thickness, -thickness],
        [-thickness, inner_width_begin+thickness], [depth, inner_width_begin+thickness], [depth, inner_width_begin-thickness_delta], [0, inner_width_begin] 
    ]);