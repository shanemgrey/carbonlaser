// #################################################################
// Global Parameters
// on another rod
// #################################################################

// GENERAL SETTINGS
// use fnLargeDiameter for objects needing more vertices for smoothness, small for boltType1s etc.
fnLargeDiameter = 40;
fnSmallDiameter = 30;
wallThicknessMin = 3; // Used for all thicknesses from part to outside, or part to part

// NON-PRINTED PARTS MEASUREMENTS

// slideRod is an outside rod that the carriages are riding on, connected to the drive
slideRodLength = 500;
slideRodDiameter = 8;

// crossRod is an inside rod that the center piece rides on
crossRodLength = 500;  // TODO define calculation to derive from slideRod dims.
crossRodDiameter = 8;

// drive belt
beltWidth = 6;
beltThickness = 1.5;

// slideCarriage rides on the outside slide rods
slideCarriageLength = 80;
slideCarriageSocketDepthMin = 20;
slideCarriageSplitWidth = 1; // How much room left for clamping force between the slide and the rod

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
// Measured gap between crossRods
gantryGap = 15; 
// mounting cutout on the gantry minimum size,
mountPlateXLength = 30;
mountPlateYLength = 30;
mountPlateZLength = 10;
//Fillet/roundover radius for the gantry
gantryFillet = 3;

teflonTapeThickness = 0.1; // The tape used inside the slides to reduce friction on the slides

// Parameters specific to outer housing corners

boardThickness = 17; // thickness of boards used for all sides
screwLength = 30; // screw length less head, used for holes
screwThreadDiameter = 3; // Outer diameter of thread, used for hole sizing
screwHeadDiameter = 9.3; // Diameter of screw head, used for countersinking
screwHeadDepth = 3.5; // Depth of countersinking
minStructuralThickness = 3; // Plastic min depth, from bottom of countersink to end of that wall
cornerSize = 30; // overall cube size for corner
tabSize = 20; // how far out the tab sticks
tabScrewDiameter = 5; // size of hole in tab
mooringHoleDiameter = 3; // Diameter of hole for attaching to a surface



// Bolt Type 1 is used for clamping the larger parts, like the slide carriage together.
// Measurements for exact bolt dimensions.
boltType1HeadDiameter = 5.35;
boltType1HeadLength = 2.9;
boltType1ShaftDiameter = 2.9;
boltType1ShaftLength = 6;
boltType1ThreadDiameter = 2.95;
boltType1ThreadLength = 8;
totalBoltLength = boltType1HeadLength+boltType1ShaftLength+boltType1ThreadLength;

// The voids left for bolts in parts
boltType1HeadHoleDiameter = boltType1HeadDiameter*1.1; // Room to fit
boltType1HeadHoleLength = boltType1HeadLength*4; // To cut out area above the hole if needed
boltType1ShaftHoleDiameter = boltType1ShaftDiameter+0.4; // To allow slippage so clamping works
boltType1ShaftHoleLength = boltType1ShaftLength;
boltType1ThreadHoleDiameter = boltType1ThreadDiameter-0.2; // To provide grab. Will need fit testing for printer
boltType1ThreadHoleLength = boltType1ThreadLength;
