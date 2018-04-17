/*
************************************************************************
WARNING:  During construction of the machine, the main moving cross members must have a minimum clearance equal to 2x the thickness of the printed walls and 2 layers of teflon tape.
************************************************************************
*/

//Global Variables
Wall = 3; // Printed wall thickness
Rail = 12; // Diameter of rail in use, assuming all rails are the same size
Teflon = 0.13; // Thickness of teflon tape to be applied after printing
Offset = 15; // Distance between main crossing beams as measured
Bolt = 5; //Assembly bolt outer diameter for pre-"drilled" holes
Covered = 100; // Length used in main carriage for each tube sleeve
SlideLen = 200; // Width of the "T"
SlideWid = 50; // Height of the "T"
Gap = 4; //Gap between top and bottom plates and center assembly for main carriage

//Mounting Plate Minimum Size
X = 30; // One side of mounting plate
Y = 30; // The other side of mounting plate
Z = 10; // Minimum height of the mounting plate

$fn=50; // Set "roundness"

module Tunnel (Length)
{
//Slide "tube"
difference()
	{
	cylinder(h=Length,d=Rail+2*Wall+2*Teflon,center=true); //main cylinder
	cylinder(h=Length+10, d=Rail+2*Teflon,center=true); //hole
	};
};

module MainCarriage ()
{
// Mounting Cutout
rotate([0,90,0]) translate([Rail/2+Teflon,Rail/2+Teflon,-Rail/2-Teflon-Wall]) difference()
	{
	cube ([X,Y,Z>2*Rail+2*Teflon+2*Wall+Offset?Z:2*Rail+2*Teflon+2*Wall+Offset], center=false);
	translate([Wall,Wall,-.5]) cube ([X,Y,Z>2*Rail+2*Teflon+2*Wall+Offset?Z+1:2*Rail+2*Teflon+2*Wall+Offset+1], center=false);
	};

// Mounting Cutout inverted
rotate([90,0,-90]) translate([Rail/2+Teflon,Rail/2+Teflon,(Rail/2+Teflon+Wall)-(Z>2*Rail+2*Teflon+2*Wall+Offset?Z:2*Rail+2*Teflon+2*Wall+Offset)]) difference()
	{
	cube ([X,Y,Z>2*Rail+2*Teflon+2*Wall+Offset?Z:2*Rail+2*Teflon+2*Wall+Offset], center=false);
	translate([Wall,Wall,-.5]) cube ([X,Y,Z>2*Rail+2*Teflon+2*Wall+Offset?Z+1:2*Rail+2*Teflon+2*Wall+Offset+1], center=false);
	};

// Fastening Block
rotate([180,90,0]) translate([Rail/2+Teflon,Rail/2+Teflon,(Rail/2+Teflon+Wall)-(Z>2*Rail+2*Teflon+2*Wall+Offset?Z:2*Rail+2*Teflon+2*Wall+Offset)])
cube ([X,Y,2*Rail+2*Teflon+2*Wall+Offset], center=false);

// Fastening Block 2
rotate([180,-90,0]) translate([Rail/2+Teflon,-Rail/2-Teflon-Y,-Rail/2-Teflon-Wall])
cube ([X,Y,2*Rail+2*Teflon+2*Wall+Offset], center=false);


// Main Cross
translate([0,0,0]) rotate([90,0,0]) Tunnel(Covered);
translate([Rail+Offset-2*Teflon,0,0]) rotate([0,0,0]) Tunnel(Covered); // Set at 90 degrees to first tube, set distance to match the measured top to bottom distance between the two rails, and including additional offset/leeway for teflon tape expected thickness

// Middle Filler X
translate([Rail/2+Offset/2,0,0])
	{
	cube([Offset-Teflon,X*2+Rail+Teflon*2,Rail+Teflon*2], center=true);
	cube([Offset-Teflon,Rail+Teflon*2,Y*2+Rail+Teflon*2], center=true);
	};

// Lower Filler X
translate([-Rail/2-Teflon-Wall/2,0,0])
	{
	cube([Wall,X*2+Rail+Teflon*2,Rail+Teflon*2], center=true);
	cube([Wall,Rail+Teflon*2,Y*2+Rail+Teflon*2], center=true);
	};
// Upper Filler X
translate([Rail*1.5+Teflon+Offset+Wall*0.5,0,0])
	{
	cube([Wall,X*2+Rail+Teflon*2,Rail+Teflon*2], center=true);
	cube([Wall,Rail+Teflon*2,Y*2+Rail+Teflon*2], center=true);
	};

// Filler Cube 1
translate([Offset+Rail,Y/2+Rail/2+Teflon,0])
cube([Rail+Teflon*2,Y,Rail+Teflon*2], center=true);
// Filler Cube 2
translate([Offset+Rail,-Y/2-Rail/2-Teflon,0])
cube([Rail+Teflon*2,Y,Rail+Teflon*2], center=true);
// Filler Cube 3
translate([0,0,Rail/2+Teflon+X/2])
cube([Rail+Teflon*2+Wall*2,Rail+Teflon*2,X], center=true);
// Filler Cube 4
translate([0,0,-Rail/2-Teflon-X/2])
cube([Rail+Teflon*2+Wall*2,Rail+Teflon*2,X], center=true);
};


module DrillCarriage()
{
difference()
	{
	MainCarriage();
// Drill holes for assembly
	rotate([0,90,0]) translate([-(Rail+X)/2,(Rail+X)/2,0])
	cylinder(h=500,d=Bolt+0.1,center=true);
	rotate([0,90,0]) translate([(Rail+X)/2,-(Rail+X)/2,0])
	cylinder(h=500,d=Bolt+0.1,center=true);
	};
};

module DrillCarriageA()
{
difference()
	{
	DrillCarriage();
	translate([-Gap/2,-Covered/2-5,-Covered/2-5]) cube([Covered+10,Covered+10,Covered+10], center=false);
	};
};

module DrillCarriageB()
{
difference()
	{
	DrillCarriage();
	union()
		{
		translate([Gap/2-(Covered+10),-Covered/2-5,-Covered/2-5]) cube([Covered+10,Covered+10,Covered+10], center=false);
		translate([(Rail+Offset)/2,-Covered/2-5,-Covered/2-5]) cube([Covered+10,Covered+10,Covered+10], center=false);
		};
	};
};

module DrillCarriageC()
{
difference()
	{
	DrillCarriage();
	union()
		{
		translate([(Rail+Offset)-Gap/2,-Covered/2-5,-Covered/2-5]) cube([Covered+10,Covered+10,Covered+10], center=false);
		translate([((Rail+Offset)/2)-(Covered+10),-Covered/2-5,-Covered/2-5]) cube([Covered+10,Covered+10,Covered+10], center=false);
		};
	};
};

module DrillCarriageD()
{
difference()
	{
	DrillCarriage();
	translate([((Rail+Offset)+Gap/2)-(Covered+10),-Covered/2-5,-Covered/2-5]) cube([Covered+10,Covered+10,Covered+10], center=false);
	};
};



module EdgeT()
{
//outside rail connector

difference()
	{
	union()
		{
		Tunnel(SlideLen);
		rotate([0,90,0]) translate([0,0,Rail/2+Teflon+(SlideWid-Rail-2*Wall-2*Teflon)/2]) Tunnel(SlideWid-Rail-2*Wall-2*Teflon);
		translate([Rail/2+2*Teflon,-Rail/2-Teflon-Wall,Rail/2+Teflon])cube([SlideWid-Rail-2*Wall-2*Teflon,Rail+2*Wall+2*Teflon,SlideLen/2-Rail/2-Teflon]);
		translate([Rail/2+2*Teflon,-Rail/2-Teflon-Wall,-SlideLen/2+Teflon])cube([SlideWid-Rail-2*Wall-2*Teflon,Rail+2*Wall+2*Teflon,SlideLen/2-Rail/2-Teflon]);
		};

	union()
		{
		rotate([90,0,0]) translate([SlideWid/2,SlideLen/4],0) cylinder(h=Rail+Teflon*2+Wall*2+10,d=Bolt,center=true);
		rotate([90,0,0]) translate([SlideWid/2,-SlideLen/4],0) cylinder(h=Rail+Teflon*2+Wall*2+10,d=Bolt,center=true);
		translate([-Rail/2-Teflon-Wall-5,-Gap/2,-SlideLen/2-5]) cube([SlideWid+10,Rail/2+Teflon+Wall+10,SlideLen+10], center=false);
		};
	};
};

module Bracket();
{
// mounting bracket for frame rails
};

//Tunnel(Covered); // empty slide tube
//MainCarriage(); // broken into 4 parts



// *************************************************************
// Recommended build process: assemble outer housing and all framework, measure offset between mobile crossing tubes, print carriage.
// For a complete printer, print the following:
// Carriage
// 1 each

DrillCarriageA();
DrillCarriageB();
DrillCarriageC();
DrillCarriageD();

// Edge Slide Half
// 8 each

//EdgeT();

// 8 each

//Bracket();
