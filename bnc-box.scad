bnc_spacing = 0.75 * 25.4;  // traditional binding post spacing seems like a good choice
// need at least 7 mm of clearance radius for hardware
bnc_clearance_radius = 8;
bnc_depth = 18;
wall_thickness = 1;
panel_thickness = 2;
panel_rabbet = 1;
box_radius = bnc_clearance_radius + wall_thickness * 2;
box_flat_side = 30;

cable_pitch = 0.1 * 25.4;  // std ribbon cable
cable_width = cable_pitch * 3;
cable_thickness = cable_pitch;
cable_retainer_height = 12;
cable_retainer_bump = 1;

epsilon = 0.1;

panel();
translate([0, box_radius * 2.5]) shell();

module panel() {
    cable_hole_outer_edge = box_radius - wall_thickness;
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
    
    hull() {
        translate([0, cable_hole_inner_edge, cable_retainer_height / 2])
        cube([wall_thickness, epsilon, cable_retainer_height], center=true);
        
        translate([-wall_thickness / 2, -box_radius / 2, 0])
        cube([wall_thickness, box_radius / 2, epsilon]);
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
    difference() {
        linear_extrude(bnc_depth + wall_thickness)
        box_2d();

        translate([0, 0, wall_thickness])
        linear_extrude(bnc_depth + epsilon)
        box_inner_2d();
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

    %cylinder(r=bnc_clearance_radius, h=bnc_depth * 2, center=true, $fn=64);
}