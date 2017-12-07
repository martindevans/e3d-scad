// e3d v6 hotend modelled from these specifications: https://wiki.e3d-online.com/wiki/E3D-v6_Documentation#Engineering_Drawings
module e3d_v6() {

    module heatsink() {

        difference() {
            union() {
                //Fins
                for (i = [0 : 1 : 10]) translate([0, 0, i * 2.5])
                    cylinder(d=22, h=1);
                translate([0, 0, 27.5]) cylinder(d=16, h=1);

                //Top assembly
                translate([0, 0, 30]) cylinder(d=16, h=3);
                translate([0, 0, 33]) cylinder(d=12, h=6);
                translate([0, 0, 39]) cylinder(d=16, h=3.7);

                //Inner cylinder
                cylinder(d1=16, d2=4.2, h=42);
            }

            union() {
                //Cut out plastic channel through middle
                translate([0, 0, -21]) cylinder(d=4.2, h=84, $fn=11);
                translate([0, 0, 36.2]) cylinder(d=8, h=20);
            }
        }
    }

    module nozzle() {

        //Specs: https://wiki.e3d-online.com/images/3/3a/V6-NOZZLE-ALL.pdf

        module hexagon(size, height) {
            boxWidth = size / 1.75;
            for (r = [-60, 0, 60])
                translate([0, 0, height / 2])
                rotate([0, 0, r])
                    cube([boxWidth, size, height], true);
        }

        difference() {
            union() {
                //Body
                translate([0, 0, 6.5]) hexagon(7, 6);
                translate([0, 0, 5]) hexagon(5, 1.5);
                translate([0, 0, 2]) hexagon(10, 3);

                //Tip
                cylinder(d1=1, d2=4, h=2, $fn=6);
            }

            union() {
                //Hole
                translate([0, 0, 3.5]) cylinder(d=3.2, h=12, $fn = 10);
                translate([0, 0, -5]) cylinder(d=0.3, h=12, $fn = 7);
            }
        }
    }

    module block() {

        // Specs: https://wiki.e3d-online.com/images/a/ab/V6-BLOCK-CARTRIDGE.pdf

        difference() {
            union() {
                cube([23, 16, 11.5], center = true);
            }

            union() {

                //Thermister cartridge hole
                translate([-15, 0, -1.75]) cube([20, 20, 1.4], center = true);

                //heater hole
                translate([9.5, 16, 0]) rotate([90, 0, 0]) cylinder(d=3.1, h=32, $fn=11);
                translate([-3, 16, -1.75]) rotate([90, 0, 0]) cylinder(d=6, h=32, $fn=13);

                //Heater screw
                translate([-9, 0, -10]) cylinder(d=3, h=20, $fn=11);

                //Heat break hole
                translate([3.5, 0, -10]) cylinder(d=6, h=20, $fn=15);
            }
        }
    }

    module heatbreak() {
        difference() {
            union() {
                cylinder(d = 6, h = 5, $fn = 12);
                translate([0, 0, 5]) cylinder(d = 2.95, h = 2.1, $fn = 10);
                translate([0, 0, 7.1]) cylinder(d = 7, h = 10, $fn = 12);
                translate([0, 0, 17.1]) cylinder(d = 6, h = 5, $fn = 10);
            }
            union() {
                translate([0, 0, -5]) cylinder(d = 2, h = 30, $fn = 8);
                translate([0, 0, 17.1]) cylinder(d = 4.2, h = 10, $fn = 10);
            }
        }
    }

    translate([3.5, 0, 0]) nozzle();
    translate([0.0, 0, 11.75]) block();
    translate([3.5, 0, 19.6]) heatsink();
    translate([3.5, 0, 12.6]) heatbreak();
}

e3d_v6();