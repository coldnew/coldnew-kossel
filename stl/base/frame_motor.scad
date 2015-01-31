include <configuration.scad>;

use <vertex.scad>;
use <nema17.scad>;

$fn = 280;

fin_w=5;
fin_d=4;  // 5x4 for the vertical extrusion fins
fins=1;   // Yes use fins

//motor_frame_height = 2.5*extrusion;
motor_frame_height = extrusion + 0.1;
motor_z_offset = 15.5; // use 1.5 for 40mm height

frame_bottom_height = 5;

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

    //     for (a = [-motor_z_offset, motor_z_offset]) {
    //         translate([0, motor_offset, a]) {
    //             // Motor shaft/pulley cutout.
    //             rotate([90, 0, 0]) cylinder(r=12, h=20, center=true);
    //             // NEMA 17 stepper motor mounting screws.
    //             for (x = [-1, 1]) for (z = [-1, 1]) {
    //                 scale([x, 1, z]) translate([31/2, -5, 31/2]) {
    //                     rotate([90, 45, 0]) cylinder(r=1.65, h=20, center=true);
    //                     // Easier ball driver access.
    //                     rotate([75, -25, 0])  cylinder(r=3, h=motor_frame_height);
    //                 }
    //             }
    //         }
    //         // show motor
    //         //    translate([0, motor_offset, a]) rotate([90, 0, 0]) % nema17();
    //     }
}
}

module frame_bottom() {
    fn = 180;
    body1_cylinder_offset = 22;  //22
    body2_cylinder_offset = -30; //-37
    height = extrusion+0.1;
    roundness = 6;
    idler_offset=0;
    idler_space=100;
    fins = 1;

    difference() {
        union() {
            if(fins > 0){
                translate([-frame_bottom_height, -frame_bottom_height, 0]) {
                    translate([29.5 + 14.5, 35, 2]) rotate([270,0,60])
                    difference(){
                        fin(54,fin_d,fin_w+1);
                        translate([-22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
                        translate([22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
                    }
                    translate([-29.5 - 4,35, 2]) rotate([270,0,120])
                    difference(){
                        fin(54,fin_d,fin_w+1);
                        translate([-22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
                        translate([22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
                    }
                }
            } // fins

            intersection() {
                translate([0, body1_cylinder_offset, 0]) cylinder(r=vertex_radius, h=frame_bottom_height, center=true, $fn=fn*2);
                translate([0, body2_cylinder_offset, 0]) rotate([0, 0, 30]) cylinder(r=50, h=frame_bottom_height+1, center=true, $fn=6);
            }

            for (z = [-height/2 + extrusion/2 , height/2 - extrusion/2] ) {
                for (a = [-1, 1]) {
                    rotate([0, 0, 30*a]) translate([-(vertex_radius-body1_cylinder_offset)*a, 111, z]) {

                        //                        % translate([0,5,0]) rotate([90, 0, 0]) extrusion_cutout(200, 0);
                        translate([3*a,-67,0]) rotate([90, 0, 0]) cube([28, frame_bottom_height, 56], center=true);
                    }
                }
            }

            translate([0, 38, 0]) intersection() {
                rotate([0, 0, -90]) cylinder(r=55, h=frame_bottom_height, center=true, $fn=3);
                translate([0, 10, 0]) cube([100, 100, 1*frame_bottom_height], center=true);
                translate([0, -10, 0]) rotate([0, 0, 30]) cylinder(r=55, h=height+1, center=true, $fn=6);
            }

        } // union

        difference() {
            translate([0, 58, 0]) minkowski() {
                intersection() {
                    rotate([0, 0, -90]) cylinder(r=55, h=height, center=true, $fn=3);
                    translate([0, -31, 0])  cube([100, 15, 2*height], center=true);
                }
                cylinder(r=roundness, h=1, center=true);
            }

            // Idler support cones.
            translate([0, 26+idler_offset-30, 0]) rotate([-90, 0, 0]) cylinder(r1=30, r2=2, h=30-idler_space/2, $fn=fn);
            translate([0, 26+idler_offset+30, 0]) rotate([90, 0, 0])  cylinder(r1=30, r2=2, h=30-idler_space/2, $fn=fn);
        }

        translate([0, 58, 0]) minkowski() {
            intersection() {
                rotate([0, 0, -90]) cylinder(r=55, h=frame_bottom_height, center=true, $fn=3);
                translate([0, 7, 0]) cube([100, 30, 2*frame_bottom_height], center=true);
            }
            cylinder(r=roundness, h=1, center=true);
        }
        translate([0,-2.5,0])extrusion_cutout(height+10, 0.15, fin_w, fin_d,corner_r=1);

        // Screw sockets.
        for (z = [-height/2 + extrusion/2 , height/2 - extrusion/2] ) {
            for (a = [-1, 1]) {
                rotate([0, 90, 30*a]) translate([-(vertex_radius-body1_cylinder_offset)+6, 111, z-18.5*a]) {
                    for (y = [-88, -44]) {
                        translate([(extrusion/2-0.6), y, 0]) rotate([0, 90, 0]) screw_socket();
                    }

                }
            }
        }




    } // difference
}

difference() {
    union() {
        translate([0, 0, motor_frame_height/2 + frame_bottom_height/2]) frame_motor();
        translate([0, 2.5, 0]) frame_bottom();
    }

    translate([0, 0, motor_frame_height/2 + frame_bottom_height/2])
    for (a = [-motor_z_offset, motor_z_offset]) {
        translate([0, motor_offset, a]) {
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
        // show motor
        //    translate([0, motor_offset, a]) rotate([90, 0, 0]) % nema17();
    }
}
