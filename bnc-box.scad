bnc_spacing = 0.75 * 25.4;  // traditional binding post spacing seems like a good choice
// need at least 7 mm of clearance radius for hardware
bnc_clearance_radius = 8;
bnc_depth = 18;
wall_thickness = 1.2;
panel_thickness = 2;
panel_rabbet = 1;
box_radius = bnc_clearance_radius + wall_thickness * 2;
box_flat_side = 30;
box_inner_edge = box_radius - wall_thickness;

shell_height = bnc_depth + wall_thickness;

cable_width = 4.3 + 0.5;  // a bitoversized to account for printing error and inentional in the other direction
cable_thickness = 1.53;
cable_retainer_height = 12;
cable_retainer_bump = 1;

snap_width = 5;
snap_ysize = 0.8;
snap_zsize = 1.0;
snap_z_from_panel_base = 6;
snap_z_from_shell_end = snap_z_from_panel_base - (panel_thickness - panel_rabbet);

epsilon = 0.1;


*test_fit();
printable();


module test_fit() {
    //color("white")
    %
    translate([0, 0, shell_height + panel_thickness - panel_rabbet])
    rotate([0, 180, 0])
    shell();

    panel();
}

module printable() {
    panel();
    translate([0, box_radius * 2.5]) shell();
}

module panel() {
    cable_hole_outer_edge = box_inner_edge;
    cable_hole_inner_edge = cable_hole_outer_edge - cable_thickness;

    linear_extrude(panel_thickness)
    difference() {
        box_inner_2d();        
        negatives();
    }
    
    linear_extrude(panel_thickness - panel_rabbet)
    difference() {
        box_2d();        
        negatives();
    }
    
    // cable retainer
    translate([0, cable_hole_inner_edge, cable_retainer_height / 2]) {
        scale([1, cable_retainer_bump / cable_retainer_height, 1])
        rotate([0, 90, 0])
        cylinder(d=cable_retainer_height, h=cable_width, center=true);
        
        translate([0, -1/2, 0])
        cube([cable_width, 1, cable_retainer_height], center=true);
    }
    
    // locking snap
    mirror([0, 1, 0]) {
        support_thickness = 1;
        // base / printing support
        translate([-snap_width / 2, box_inner_edge - support_thickness, 0])
        cube([snap_width, support_thickness, snap_z_from_panel_base + snap_zsize]);
        
        // actual snap
        translate([-snap_width / 2, box_inner_edge, snap_z_from_panel_base])
        cube([snap_width, snap_ysize, snap_zsize]);
    }
    
    hull() {
        translate([0, cable_hole_inner_edge, cable_retainer_height / 2])
        cube([wall_thickness, epsilon, cable_retainer_height], center=true);

        translate([0, -box_inner_edge + epsilon, snap_z_from_panel_base / 2])
        cube([wall_thickness, epsilon, snap_z_from_panel_base], center=true);
    }

    module negatives() {
        translate([-bnc_spacing / 2, 0])
        bnc_hole_2d();
        
        translate([bnc_spacing / 2, 0])
        bnc_hole_2d();

        translate([0, (cable_hole_outer_edge + cable_hole_inner_edge) / 2])
        square([cable_width, cable_thickness], center=true);
    }
}

module shell() {
    snap_clearance_x = 0.4;
    snap_clearance_z = 0.3;
    
    difference() {
        linear_extrude(shell_height)
        box_2d();

        translate([0, 0, wall_thickness])
        linear_extrude(shell_height - wall_thickness + epsilon)
        box_inner_2d();
        
        translate([
            -(snap_width / 2 + snap_clearance_x),
            -box_radius - epsilon,
            shell_height - snap_z_from_shell_end - (snap_zsize + snap_clearance_z)])
        cube([snap_width + snap_clearance_x * 2, wall_thickness + epsilon * 2, snap_zsize + snap_clearance_z]);
    }
}

module box_inner_2d() {
    offset(r=-wall_thickness)
    box_2d();
}

module box_2d() {
    // square([bnc_spacing + bnc_clearance_radius * 2, bnc_clearance_radius * 2], center=true);
    
    hull() {
        bnc_positions()
        circle(r=box_radius, $fn = 128);
                
        translate([-box_flat_side / 2, 0])
        square([box_flat_side, box_radius]);
    }
}

module bnc_positions() {
    translate([-bnc_spacing / 2, 0]) children();
    translate([bnc_spacing / 2, 0]) children();
}

module bnc_hole_2d() {
    // Dimensions per https://www.amphenolrf.com/downloads/dl/file/id/1010/product/459/031_221_rfx_customer_drawing.pdf
    diameter = 9.7;
    flat_diameter = 8.85;
    intersection() {
        circle(d=diameter, $fn=64);
        translate([0, (flat_diameter - diameter) / 2])
        square([diameter, flat_diameter], center=true);
    }

    *%cylinder(r=bnc_clearance_radius, h=bnc_depth * 2, center=true, $fn=64);
}