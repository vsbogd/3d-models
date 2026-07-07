$fn=50;
thick = 0.6;
marks = 0.2;
logo = 0.4;

difference() {
    linear_extrude(height=thick) {
        difference() {
            import(file="./external.svg");
            
            union() {
                import(file="./internal.svg");
                import(file="./button.svg");
            }
        }
    }

    
    translate([0, 0, thick - marks + 0.001])
        linear_extrude(height=marks)
            import(file="./up_button.svg");
    
    translate([0, 0, thick - logo + 0.001]) 
        linear_extrude(height=logo)
            import(file="./logo.svg");
}

down_button = 3.7;
translate([0, 0, -down_button])
    linear_extrude(height=down_button)
        import(file="./down_button.svg");
