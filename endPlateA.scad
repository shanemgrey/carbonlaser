//Global Variables
wallMin = 3; // Printed wall thickness
slideRodDiameter = 12; // Diameter of rail in use, assuming all rails are the same size
slideRodInsertionDepth = 15; // How far the hole in the center tube should extend
mountingPlateX = 35; // Left/right size of plate
mountingPlateY = 35; // Up/down size of plate
mountingPlateZ = 3; // Mounting plate thickness
screwShaftDiameter = 3; // Screw hole min size
rounding = 3; // Fillet/round nosing radius
// pulleyDiameter = ; // Diameter of the bearing/pulley at the point where the belt/line will ride.
// pulleyWidth = ; // How wide the bearing/pulley is
// pulleyClearance = ; // Extra space around pulley circumphrence, for V-pulleys this needs to include the "depth" of the V in addition to actual offset/clearance

//drill at 1/2 between edge and diameter

module EndSupport(){
    //main flange and hull for mounting pulley/bearing
    difference(){
    union(){
    cube([mountingPlateX, mountingPlateY, wallMin>mountingPlateZ?wallMin:mountingPlateZ], center=true);
    cylinder(h=slideRodInsertionDepth,d=slideRodDiameter+2*wallMin, center=false);
    };
    cylinder(h=50, d=slideRodDiameter, center=false);

};
};


EndSupport();
