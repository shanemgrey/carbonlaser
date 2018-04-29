// #################################################################
// Global Parameters
// on another rod
// #################################################################

// use fnLargeDiameter for objects needing more vertices for smoothness, small for boltType1s etc.
fnLargeDiameter = 40;
fnSmallDiameter = 12;

// slideRod is an outside rod that the carriages are riding on, connected to the drive
slideRodLength = 1000;
slideRodDiameter = 12;

crossRodLength = 1000;  // TODO define calculation to derive from slideRod dims.
crossRodDiameter = 12;

beltWidth = 6;
beltThickness = 1;

// values should be based on your print strength and precision balanced with print time and weight
wallThicknessMin = 3; // Used for all thicknesses from part to outside, or part to part
slideSplitWidth = 1; // How much room left for clamping force between the slide and the rod

// slideCarriage rides on the outside slide rods
slideCarriageLength = 100;
slideCarriageSocketDepthMin = 20;

// EndSupport attaches to the outside wall and holds the stationary slide rods and pulleys
endSupportRodInsertionDepth = 30;

// Motor Side Pulleys
motorSidePulleyBearingInsideDiameter = 4; // The hole in the bearing
motorSidePulleyBearingInsideDiameter2 = 6; // The diameter of the center ring on which to hold the bearing
motorSidePulleyBearingOutsideDiameter = 13; // The diameter of the outside of the bearing

motorSidePulleyBeltPathDiameter = motorSidePulleyBearingOutsideDiameter+4; // Where the belt rides
motorSidePulleyBeltPathWidth = beltWidth+1; // Where the belt rides
edgeWallThickness = 2;
motorSidePulleyEdgeDiameter = motorSidePulleyBeltPathDiameter+beltThickness*2; // The Max Diameter including the ridges that guide the belt in
motorSidePulleyTotalThickness = motorSidePulleyBeltPathWidth+edgeWallThickness*2; // Adds thickness for the edges
motorSidePulleyBeltClearance = 3; // Extra space around pulley circumference
motorSidePulleySideClearance = 0.5; // Space of pulley set off from bracket
motorSidePulleyMountTotalThickness = wallThicknessMin*3;
mountingScrewHoleDiameter = 3;
mountingScrewHeadDiameter = 6;
mountingPlateX = motorSidePulleyMountTotalThickness + mountingScrewHeadDiameter*2 + 1; // Left/right size of plate
mountingPlateY = motorSidePulleyMountTotalThickness + mountingScrewHeadDiameter*2 + 1 +motorSidePulleyEdgeDiameter; // Up/down size of plate
mountingPlateZ = 3; // Mounting plate thickness

// gantry rides at the intersection of the crossRods
gantryXLength = 100;
gantryYLength = 100;

teflonTapeThickness = 0.1; // The tape used inside the slides to reduce friction on the slides



// Measurements for exact bolt dimensions.
// The voids left for bolts in parts will be calculated based on this in the boltHole module
boltType1HeadDiameter = 4;
boltType1ShaftDiameter = 3;
boltType1ThreadDiameter = 2.5;
boltType1HeadLength = 4;
boltType1ShaftLength = 3;
boltType1ThreadLength = 2.5;
totalBoltLength = slideRodDiameter+wallThicknessMin*3; // TODO, change code to use above lengths instead


// #### Calculated values:  These can be or must be calculated from the input parameters
// crossRodLength = 1000;  // TODO define calculation to derive from slideRod dims.
