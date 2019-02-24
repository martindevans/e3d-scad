// https://wiki.e3d-online.com/images/f/f1/AERO_SINK_175.pdf

module e3d_titan_aero() {

    module heatsink_fins() {

        module angled_backing_plate(extrude = 2) {
            rotate([0, 0, 45]) linear_extrude(extrude) minkowski() {
                square([32, 32], center=true);
                circle(r=4, $fn = 15);
            }
        }

        module basic_fins() {
            intersection() {
                angled_backing_plate(200);
                translate([0, -0.9, 0]) union() {

                    //First and last fins are thicker
                    translate([-25, -28.5, 2]) cube([100, 5.6, 7]);
                    translate([-25, -28.5 + 14 * 3.8, 2]) cube([100, 5.6, 7]);

                    //All the mid fins
                    for (i = [2:13]) translate([-50, -28.5 + i * 3.8, 2]) cube([100, 1.8, 7]);
                }
            }
        }

        difference() {

            basic_fins();

            union() {
                //Fan screw holes
                translate([0, -22.63, 0]) rotate([0, 0, 45]) union() {
                    translate([32, 00, 0]) cylinder(d = 3, h = 100, $fn = 10);
                    translate([00, 32, 0]) cylinder(d = 3, h = 100, $fn = 10);
                    translate([32, 32, 0]) cylinder(d = 3, h = 100, $fn = 10);
                    translate([00, 00, 0]) cylinder(d = 3, h = 100, $fn = 10);
                }

                //Fin cutouts
                translate([10, 8, 0]) cube([50, 7, 50]);
                translate([-64.5, 8, 0]) cube([50, 7, 50]);
            }
        }
    }

    module heatsink_back_plate() {


        translate([-21.8, 16, 0]) union() {
            difference() {
                union() {

                    //Center point
                    translate([19.5, -19.5, -4]) difference() {
                        cylinder(d=9, h=4);
                        translate([0, 0, -3]) cylinder(d=5.5, h=8, $fn=12);
                    }

                    //Filament path
                    translate([31, -42.5, -15]) cube([10, 5, 5], center=true);
                }
                #union() {
                    //Holes through the back plate
                    translate([4,  -4,    -30]) cylinder(d=3.3, h=100, $fn=12);
                    translate([4,  -35,   -30]) cylinder(d=3.3, h=100, $fn=12);
                    translate([41, -34.5, -30]) cylinder(d=3.3, h=100, $fn=12);
                    translate([35, -4,    -30]) cylinder(d=3.3, h=100, $fn=12);
                }
            }
        }
    }

    union() {    
        heatsink_fins();
        heatsink_back_plate();
    }

    color("red") rotate([0, 180, 180]) translate([-9, 26.5, 24.1]) import("titan_heatsink.stl", convexity=5);
}

e3d_titan_aero();

