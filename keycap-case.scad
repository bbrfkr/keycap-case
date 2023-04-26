side=19.05;
wall_thin=1.6;
sep_thin=1.6;
$sep_height=5;
wall_distance=5;
$wall_height=13.6;

module key_space(width_unit=1,depth_unit=1){
    mirror([0,1,0]){
        difference(){
            cube([
                (side+sep_thin)*width_unit,
                (side+sep_thin)*depth_unit,
                wall_thin+$sep_height
            ]);
            translate([sep_thin/2,sep_thin/2,wall_thin]) {
                cube([
                    (side+sep_thin)*width_unit-sep_thin,
                    (side+sep_thin)*depth_unit-sep_thin,
                    $sep_height
                ]);
            }
        }
    }
}

module iso_key_space(){
    mirror([0,1,0]){
        difference(){
            union(){
                cube([
                    (side+sep_thin)*1.5,
                    (side+sep_thin),
                    wall_thin+$sep_height
                ]);
                translate([(side+sep_thin)*0.25,side+sep_thin,0]){
                    cube([
                        (side+sep_thin)*1.25,
                        (side+sep_thin),
                        wall_thin+$sep_height
                    ]);
                }

            }
            translate([sep_thin/2,sep_thin/2,wall_thin]) {
                union(){
                    cube([
                        (side+sep_thin)*1.5-sep_thin,
                        (side+sep_thin)-sep_thin,
                        $sep_height
                    ]);
                    translate([(side+sep_thin)*0.25,side,0]){
                        cube([
                            (side+sep_thin)*1.25-sep_thin,
                            sep_thin,
                            $sep_height
                        ]);
                    }
                    translate([(side+sep_thin)*0.25,side+sep_thin,0]){
                        cube([
                            (side+sep_thin)*1.25-sep_thin,
                            (side+sep_thin)-sep_thin,
                            $sep_height
                        ]);
                    }
                }
            }
        }
    }
}

module revert_iso_key_space(){
    rotate([0,0,180]) translate([-(side+sep_thin)*1.5,(side+sep_thin)*2,0]){
        iso_key_space();
    }
}

module iso_key_spaces(){
    union(){
        revert_iso_key_space();
        translate([(side+sep_thin)*1.25,0,0]){
            iso_key_space();
        }
    }
}

module row_1u_only(unit=1) {
    union(){
        for (index = [0:unit-1]) {
            translate([(side+sep_thin)*index,0,0]){
                key_space(1);
            }
        }
    }
}

module row_1() {
    union(){
        for (index = [0:12]) {
            translate([(side+sep_thin)*index,0,0]){
                key_space(1);
            }
        }
        translate([(side+sep_thin)*13,0,0]){
            key_space(2);
        }
    }
}

module row_2() {
    union(){
        key_space(1.5);
        for (index = [0:11]) {
            translate([(side+sep_thin)*1.5+(side+sep_thin)*index,0,0]){
                key_space(1);
            }
        }
        translate([(side+sep_thin)*13.5,0,0]){
            key_space(1.5);
        }
    }
}

module row_3() {
    union(){
        key_space(1.75);
        for (index = [0:10]) {
            translate([(side+sep_thin)*1.75+(side+sep_thin)*index,0,0]){
                key_space(1);
            }
        }
        translate([
            (side+sep_thin)*12.75,0,0]){
            key_space(2.25);
        }
    }
}

module row_4() {
    union(){
        key_space(2.25);
        for (index = [0:9]) {
            translate([(side+sep_thin)*2.25+(side+sep_thin)*index,0,0]){
                key_space(1);
            }
        }
        translate([
            (side+sep_thin)*12.25,0,0]){
            key_space(2.75);
        }
    }
}

module row_6_25space() {
    union(){
        for (index = [0:2]) {
            translate([(side+sep_thin)*1.25*index,0,0]){
                key_space(1.25);
            }
        }
        translate([(side+sep_thin)*1.25*3,0,0]){
            key_space(6.25);
        }
        for (index = [0:3]) {
            translate([
                (side+sep_thin)*10+(side+sep_thin)*1.25*index,
                0,
                0
            ]){
                key_space(1.25);
            }
        }
    }
}

module row_7space() {
    union(){
        key_space(1.5);
        translate([(side+sep_thin)*1.5,0,0]){
            key_space(1);
        }
        translate([(side+sep_thin)*2.5,0,0]){
            key_space(1.5);
        }
        translate([
            (side+sep_thin)*4,
            0,
            0
        ]){
            key_space(7);
        }
        translate([(side+sep_thin)*11,0,0]){
            key_space(1.5);
        }
        translate([(side+sep_thin)*12.5,0,0]){
            key_space(1);
        }
        translate([(side+sep_thin)*13.5,0,0]){
            key_space(1.5);
        }

    }
}

module inner_wall(width_unit=15,depth_unit=6){
    mirror([0,1,0]){
        difference(){
            cube([
                (side+sep_thin)*width_unit+sep_thin,
                (side+sep_thin)*depth_unit+sep_thin,
                wall_thin+$sep_height
            ]);
            translate([sep_thin/2,sep_thin/2,wall_thin]) {
                cube([
                    (side+sep_thin)*width_unit,
                    (side+sep_thin)*depth_unit,
                    $sep_height
                ]);
            }
        }
    }
}

module tray_wall(width_unit=15, depth_unit=6){
    mirror([0,1,0]){
        difference(){
            cube([
                (side+sep_thin)*width_unit+sep_thin+wall_distance*2+wall_thin*2,
                (side+sep_thin)*depth_unit+sep_thin+wall_distance*2+wall_thin*2,
                wall_thin+$wall_height
            ]);
            translate([wall_thin,wall_thin,wall_thin]) {
                cube([
                    (side+sep_thin)*width_unit+sep_thin+wall_distance*2,
                    (side+sep_thin)*depth_unit+sep_thin+wall_distance*2,
                    $wall_height
                ]);
            }
        }
    }
}

module tray_ceil(width_unit=15, depth_unit=6){
    clearance=0.1;
    mirror([0,1,0]){
        union(){
            cube([
                (side+sep_thin)*width_unit+sep_thin+wall_distance*2+wall_thin*2,
                (side+sep_thin)*depth_unit+sep_thin+wall_distance*2+wall_thin*2,
                wall_thin
            ]);
            translate([wall_thin+clearance,wall_thin+clearance,wall_thin]) {
                cube([
                    (side+sep_thin)*width_unit+sep_thin+(wall_distance-clearance)*2,
                    (side+sep_thin)*depth_unit+sep_thin+(wall_distance-clearance)*2,
                    wall_thin
                ]);
            }
        }
    }
}

module basekit_tray(){
    union(){
        tray_wall();
        translate([
            wall_thin+wall_distance,
            -(wall_thin+wall_distance),
            0
        ]){
            inner_wall();
            translate([sep_thin/2,-sep_thin/2,0]){
                row_1();
                translate([0,-(side+sep_thin),0]) row_2();
                translate([0,-2*(side+sep_thin),0]) row_3();
                translate([0,-3*(side+sep_thin),0]) row_4();
                translate([0,-4*(side+sep_thin),0]) row_6_25space();
                translate([0,-5*(side+sep_thin),0]) row_7space();
            }
        }
    }
}

module optionkit_tray(){
    union(){
        tray_wall();
        translate([
            wall_thin+wall_distance,
            -(wall_thin+wall_distance),
            0
        ]){
            inner_wall();
            translate([sep_thin/2,-sep_thin/2,0]){
                key_space(14); translate([(side+sep_thin)*14,0,0]) key_space(1,2);
                translate([0,-(side+sep_thin),0]) key_space(14); 
                translate([0,-2*(side+sep_thin),0]){
                    key_space(14); translate([(side+sep_thin)*14,0,0]) key_space(1,2);
                }
                translate([0,-3*(side+sep_thin),0]) key_space(14);
                translate([0,-4*(side+sep_thin),0]) {
                    key_space(12.25);
                    translate([(side+sep_thin)*12.25,0,0]) iso_key_spaces();
                }
                translate([0,-5*(side+sep_thin),0]) key_space(12.25);
            }
        }
    }
}

module additional_tray(){
    union(){
        tray_wall();
        translate([
            wall_thin+wall_distance,
            -(wall_thin+wall_distance),
            0
        ]){
            inner_wall();
            translate([sep_thin/2,-sep_thin/2,0]){
                key_space(15);
                translate([0,-(side+sep_thin),0]) key_space(15);
                translate([0,-2*(side+sep_thin),0]) key_space(15);
                translate([0,-3*(side+sep_thin),0]) key_space(15);
                translate([0,-4*(side+sep_thin),0]) key_space(15);
                translate([0,-5*(side+sep_thin),0]) key_space(15);
            }
        }
    }
}

module multi_units_standard_tray(width_unit=2, depth_unit=2){
    union(){
        tray_wall(width_unit,depth_unit);
        translate([
            wall_thin+wall_distance,
            -(wall_thin+wall_distance),
            0
        ]){
            inner_wall(width_unit,depth_unit);
            translate([sep_thin/2,-sep_thin/2,0]){
                for(index=[0:depth_unit-1]){
                    translate([0,-index*(side+sep_thin),0]) key_space(width_unit);
                }
            }
        }
    }
}

module artisan_tray(width_unit=12, depth_unit=5){
    union(){
        tray_wall(width_unit,depth_unit);
        translate([
            wall_thin+wall_distance,
            -(wall_thin+wall_distance),
            0
        ]){
            inner_wall(width_unit,depth_unit);
            translate([sep_thin/2,-sep_thin/2,0]){
                for(index=[0:depth_unit-1]){
                    translate([0,-index*(side+sep_thin),0]){
                        row_1u_only(unit=width_unit);
                    }
                }
            }
        }
    }
}

module tray_case(width_unit=15, depth_unit=6, tray_count=2){
    clearance=0.35;
    tray_width=(side+sep_thin)*width_unit+sep_thin+wall_distance*2+wall_thin*2;
    tray_depth=(side+sep_thin)*depth_unit+sep_thin+wall_distance*2+wall_thin*2;
    tray_height=$wall_height+wall_thin*2+clearance;
    mirror([0,1,0]){
        difference(){
            difference(){
                cube([
                    tray_width+((wall_thin*2.5)+clearance)*2,
                    tray_depth+(wall_thin*2.5)+clearance*2,
                    tray_height*tray_count+(wall_thin*2.5)*2+clearance*(2+tray_count-1)
                ]);
                translate([(wall_thin*2.5),0,(wall_thin*2.5)]) {
                    cube([
                        tray_width+clearance*2,
                        tray_depth+clearance*2,
                        tray_height*tray_count+clearance*(2+tray_count-1)
                    ]);
                }
            }
            translate([(tray_width+((wall_thin*2.5)+clearance)*2)/2,0,0]) {
                $fn=64;
                cylinder(500, 15, 15, true);
            }
        }
    }
}

// for high profile
//$wall_height=20.75;
//$sep_height=7.5;

// for artisan case
//artisan_tray(12,5);
//multi_units_standard_tray(12,5);
//tray_ceil(12,5);

// for standard case
//basekit_tray();
//optionkit_tray();
//multi_units_standard_tray(15,6);
//tray_ceil();
//tray_case();

// for case test
//tray_case();
//translate([wall_thin+0.1,-0.1,wall_thin+0.1]){
//    union(){
//        basekit_tray();
//        translate([0,0,wall_thin*2+$wall_height]) mirror([0,0,1]) tray_ceil();
//    }
//}
//translate([wall_thin+0.1,-0.1,wall_thin+$wall_height+wall_thin*2+0.3]){
//    union(){
//        basekit_tray();
//        translate([0,0,wall_thin*2+$wall_height]) mirror([0,0,1]) tray_ceil();
//    }
//}
//iso_key_space();
