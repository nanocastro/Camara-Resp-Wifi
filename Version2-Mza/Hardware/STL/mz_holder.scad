caja_x=42;
caja_y=62;
caja_z=22;
mz_x=27;
mz_y=20;
mz_z=9;
mz_hole_x=3;
e=2;

difference(){
union(){
cube([caja_x,caja_y,e]);
 translate([(caja_x-mz_x-2*mz_hole_x)/2,(caja_y-mz_y-2*e)/2,0])
 cube([mz_x+2*mz_hole_x,mz_y+2*e,caja_z-mz_z-2*e]);
translate([0,0,caja_z-mz_z-2*e])
difference(){
translate([(caja_x-mz_x-2*mz_hole_x)/2,(caja_y-mz_y-2*e)/2,0])
 cube([mz_x+2*mz_hole_x,mz_y+2*e,e*2]);
translate([0,(caja_y-mz_y+2*e-2*e)/2,e])
    cube([caja_x,mz_y,caja_z]);
translate([e,0,e])
    cube([caja_x/2,caja_y/2,2*e]);   
}}
translate([2*e,caja_y/2-(mz_y-2*e)/2,0])  
cube([mz_hole_x,mz_y-2*e,caja_z]);
    translate([4*e+mz_x,caja_y/2-(mz_y-2*e)/2,0])  
cube([mz_hole_x,mz_y-2*e,caja_z]);
translate([2*e,2*e,0])
#cylinder(h=10,d=3,center=true);
translate([caja_x-2*e,2*e,0])
#cylinder(h=10,d=3,center=true);
translate([caja_x-2*e,caja_y-2*e,0])
#cylinder(h=10,d=3,center=true);
translate([2*e,caja_y-2*e,0])
#cylinder(h=10,d=3,center=true);


}