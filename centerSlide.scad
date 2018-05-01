/*
************************************************************************
WARNING:  During construction of the machine, the main moving cross members must have a minimum clearance equal to 2x the thickness of the printed walls and 2 layers of teflon tape.
************************************************************************
*/
// dependancies
include <parameters.scad>


// *************************************************************
// Recommended build process: assemble outer housing and all framework, measure offset between mobile crossing tubes, print carriage.
// For a complete printer, print the following:
// Carriage
// 1 each

DrillCarriageA();
DrillCarriageB();
DrillCarriageC();
DrillCarriageD();


module MainCarriage ()
{
    //rounding, by creating a bounding box of the correct shape for the outside.  Tubes added later
    intersection(){
minkowski(){
    translate([(-crossRodDiameter/2-teflonTapeThickness-wallMinThickness)+gantryFillet,((mountPlateXLength*2+crossRodDiameter+teflonTapeThickness*2)/-2)+gantryFillet,((mountPlateYLength*2+crossRodDiameter+teflonTapeThickness*2)/-2)+gantryFillet]) cube([(2*crossRodDiameter+2*wallMinThickness+2*teflonTapeThickness+gantryGap)-2*gantryFillet,(mountPlateXLength*2+crossRodDiameter+teflonTapeThickness*2)-2*gantryFillet,(mountPlateYLength*2+crossRodDiameter+teflonTapeThickness*2)-2*gantryFillet],center=false);
    sphere(r=gantryFillet, $fn = fnSmallDiameter);
};
union(){
// Fastening Block
rotate([180,90,0]) translate([crossRodDiameter/2+teflonTapeThickness,crossRodDiameter/2+teflonTapeThickness,(crossRodDiameter/2+teflonTapeThickness+wallMinThickness)-(mountPlateZLength>2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap?mountPlateZLength:2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap)])
cube ([mountPlateXLength,mountPlateYLength,2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap], center=false);

// Fastening Block 2
rotate([180,-90,0]) translate([crossRodDiameter/2+teflonTapeThickness,-crossRodDiameter/2-teflonTapeThickness-mountPlateYLength,-crossRodDiameter/2-teflonTapeThickness-wallMinThickness])
cube ([mountPlateXLength,mountPlateYLength,2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap], center=false);




// Middle Filler Cross
translate([crossRodDiameter/2+gantryGap/2,0,0])
	{
	cube([gantryGap-teflonTapeThickness,mountPlateXLength*2+crossRodDiameter+teflonTapeThickness*2,crossRodDiameter+teflonTapeThickness*2], center=true);
	cube([gantryGap-teflonTapeThickness,crossRodDiameter+teflonTapeThickness*2,mountPlateYLength*2+crossRodDiameter+teflonTapeThickness*2], center=true);
	};

// Lower Filler Cross
translate([-crossRodDiameter/2-teflonTapeThickness-wallMinThickness/2,0,0])
	{
	cube([wallMinThickness,mountPlateXLength*2+crossRodDiameter+teflonTapeThickness*2,crossRodDiameter+teflonTapeThickness*2], center=true);
	cube([wallMinThickness,crossRodDiameter+teflonTapeThickness*2,mountPlateYLength*2+crossRodDiameter+teflonTapeThickness*2], center=true);
	};
// Upper Filler Cross
translate([crossRodDiameter*1.5+teflonTapeThickness+gantryGap+wallMinThickness*0.5,0,0])
	{
	cube([wallMinThickness,mountPlateXLength*2+crossRodDiameter+teflonTapeThickness*2,crossRodDiameter+teflonTapeThickness*2], center=true);
	cube([wallMinThickness,crossRodDiameter+teflonTapeThickness*2,mountPlateYLength*2+crossRodDiameter+teflonTapeThickness*2], center=true);
	};

// Filler Cube 1
translate([gantryGap+crossRodDiameter,mountPlateYLength/2+crossRodDiameter/2+teflonTapeThickness,0])
cube([crossRodDiameter+teflonTapeThickness*2,mountPlateYLength,crossRodDiameter+teflonTapeThickness*2], center=true);
// Filler Cube 2
translate([gantryGap+crossRodDiameter,-mountPlateYLength/2-crossRodDiameter/2-teflonTapeThickness,0])
cube([crossRodDiameter+teflonTapeThickness*2,mountPlateYLength,crossRodDiameter+teflonTapeThickness*2], center=true);
// Filler Cube 3
translate([0,0,crossRodDiameter/2+teflonTapeThickness+mountPlateXLength/2])
cube([crossRodDiameter+teflonTapeThickness*2+wallMinThickness*2,crossRodDiameter+teflonTapeThickness*2,mountPlateXLength], center=true);
// Filler Cube 4
translate([0,0,-crossRodDiameter/2-teflonTapeThickness-mountPlateXLength/2])
cube([crossRodDiameter+teflonTapeThickness*2+wallMinThickness*2,crossRodDiameter+teflonTapeThickness*2,mountPlateXLength], center=true);
};
};
// Main Cross
translate([0,0,0]) rotate([90,0,0]) Tunnel(gantryYLength);
translate([crossRodDiameter+gantryGap-2*teflonTapeThickness,0,0]) rotate([0,0,0]) Tunnel(gantryXLength); // Set at 90 degrees to first tube, set distance to match the measured top to bottom distance between the two rails, and including additional offset/leeway for teflon tape expected thickness


// Mounting Cutout
rotate([0,90,0]) translate([crossRodDiameter/2+teflonTapeThickness,crossRodDiameter/2+teflonTapeThickness,-crossRodDiameter/2-teflonTapeThickness-wallMinThickness]) difference()
	{
	cube ([mountPlateXLength,mountPlateYLength,mountPlateZLength>2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap?mountPlateZLength:2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap], center=false);
	translate([wallMinThickness,wallMinThickness,-.5]) cube ([mountPlateXLength,mountPlateYLength,mountPlateZLength>2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap?mountPlateZLength+1:2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap+1], center=false);
	};

// Mounting Cutout inverted
rotate([90,0,-90]) translate([crossRodDiameter/2+teflonTapeThickness,crossRodDiameter/2+teflonTapeThickness,(crossRodDiameter/2+teflonTapeThickness+wallMinThickness)-(mountPlateZLength>2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap?mountPlateZLength:2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap)]) difference()
	{
	cube ([mountPlateXLength,mountPlateYLength,mountPlateZLength>2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap?mountPlateZLength:2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap], center=false);
	translate([wallMinThickness,wallMinThickness,-.5]) cube ([mountPlateXLength,mountPlateYLength,mountPlateZLength>2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap?mountPlateZLength+1:2*crossRodDiameter+2*teflonTapeThickness+2*wallMinThickness+gantryGap+1], center=false);
	};

};

module Tunnel (Length)
{
//Slide "tube"
difference()
	{
	cylinder(h=Length,d=crossRodDiameter+2*wallMinThickness+2*teflonTapeThickness,center=true, $fn = fnLargeDiameter); //main cylinder
	cylinder(h=Length+10, d=crossRodDiameter+2*teflonTapeThickness,center=true, $fn = fnLargeDiameter); //hole
	};
};
module DrillCarriage()
{
difference()
	{
	MainCarriage();
// Drill holes for assembly
	rotate([0,90,0]) translate([-(crossRodDiameter+mountPlateXLength)/2,(crossRodDiameter+mountPlateXLength)/2,0])
	cylinder(h=500,d=boltType1ShaftDiameter+0.1,center=true, $fn = fnSmallDiameter);
	rotate([0,90,0]) translate([(crossRodDiameter+mountPlateXLength)/2,-(crossRodDiameter+mountPlateXLength)/2,0])
	cylinder(h=500,d=boltType1ShaftDiameter+0.1,center=true, $fn = fnSmallDiameter);
	};
};

module DrillCarriageA()
{
intersection()
	{
	DrillCarriage();
	translate([-slideSplitWidth/2-(wallMinThickness+teflonTapeThickness+crossRodDiameter/2),-gantryYLength/2,-gantryXLength/2]) cube([wallMinThickness+teflonTapeThickness+crossRodDiameter/2,gantryYLength,gantryXLength],center=false);
	};
};

module DrillCarriageB()
{
intersection()
	{
	DrillCarriage();
	translate([slideSplitWidth/2,-gantryYLength/2,-gantryXLength/2]) cube([(gantryGap/2+wallMinThickness+teflonTapeThickness+crossRodDiameter/2),gantryYLength,gantryXLength],center=false);	
	};
};

module DrillCarriageC()
{
intersection()
	{
	DrillCarriage();
	translate([gantryGap/2+crossRodDiameter/2,-gantryYLength/2,-gantryXLength/2]) cube([crossRodDiameter/2+gantryGap/2-slideSplitWidth/2,gantryYLength,gantryXLength],center=false);
	};
};

module DrillCarriageD()
{
intersection()
{
	DrillCarriage();
	translate([slideSplitWidth/2+gantryGap+2*teflonTapeThickness+2*wallMinThickness+crossRodDiameter/2,-gantryYLength/2,-gantryXLength/2]) cube([wallMinThickness+teflonTapeThickness+crossRodDiameter/2,gantryYLength,gantryXLength],center=false);
};
};