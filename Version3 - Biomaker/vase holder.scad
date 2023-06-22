difference(){
cylinder(h=60,d=103,center=true);
translate([0,30,0])
    cube([120,60,100],center=true);
rotate([-90,0,0])
    translate([0,0,-52])
#cylinder(h=60,d1=47,d2=72);
}