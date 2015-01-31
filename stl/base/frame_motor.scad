include <configuration.scad>;

use <vertex.scad>;
use <nema17.scad>;

$fn = 280;

fin_w=5;
fin_d=4;  // 5x4 for the vertical extrusion fins
fins=1;   // Yes use fins

//motor_frame_height = 2.5*extrusion;
motor_frame_height = extrusion + 0.1;
motor_z_offset = 15; // use 1.5 for 40mm height

module frame_motor() {
    difference() {
        // No idler cones.
//        vertex(motor_frame_height, idler_offset=0, idler_space=100, fin_w=fin_w, fin_d=fin_d, fins=fins, fn=200);
    vertex(extrusion+0.1, idler_offset=0, idler_space=100, fin_w=5.2, fin_d=4, fins=1, fn=280);

        // // Motor cable paths.
        // for (mirror = [-1, 1]) scale([mirror, 1, 1]) {
        //     translate([-35, 45, 0]) rotate([0, 0, -30])
        //     cube([4, 15, 15], center=true);
        //     translate([-6-3, 0, 0]) cylinder(r=3.5, h=40);
        //     translate([-11, 0, 0])  cube([15, 5.2, 15], center=true);
        // }

        translate([0, motor_offset, motor_z_offset]) {
            // Motor shaft/pulley cutout.
            rotate([90, 0, 0]) cylinder(r=12, h=20, center=true);
            // NEMA 17 stepper motor mounting screws.
            for (x = [-1, 1]) for (z = [-1, 1]) {
                scale([x, 1, z]) translate([31/2, -5, 31/2]) {
                    rotate([90, 45, 0]) cylinder(r=1.65, h=20, center=true);
                    // Easier ball driver access.
                    rotate([75, -25, 0])  cylinder(r=3, h=motor_frame_height);
                }
            }
        }
        translate([0, motor_offset, motor_z_offset]) rotate([90, 0, 0]) % nema17();
    }
}


translate([0, 0, motor_frame_height/2]) frame_motor();
