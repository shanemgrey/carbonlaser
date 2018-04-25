// #################################################################
// Global Parameters
// on another rod
// #################################################################

// use fnLargeDiameter for objects needing more vertices for smootheness, small for boltType1s etc.
fnLargeDiameter = 100;
fnSmallDiameter = 12;

// slideRod is an outside rod that the carriages are riding on, connected to the drive
slideRodLength = 1000;
slideRodDiameter = 12;

crossRodLength = 1000;  // TODO define calculation to derive from slideRod dims.
crossRodDiameter = 12;

// slideCarriage rides on the outside slide rods
slideCarriageLength = 100;
slideCarriageSocketDepthMin = 20;

// gantry rides on at the intersection of the crossRods
gantryXLength = 100;
gantryYLength = 100;

teflonTapeThickness = 0.1; // The tape used inside the slides to reduce friction on the slides

// values should be based on your print strength and precision balanced with print time and weight
wallMinThickness = 3; // Used for all thicknesses from part to outside, or part to part
slideSplitWidth = 1; // How much room left for clamping force between the slide and the rod


// Measurements for exact bolt dimensions.
// The voids left for bolts in parts will be calculated based on this in the boltHole module
boltType1HeadDiameter = 4;
boltType1ShaftDiameter = 3;
boltType1ThreadDiameter = 2.5;
boltType1HeadLength = 4;
boltType1ShaftLength = 3;
boltType1ThreadLength = 2.5;
totalBoltLength = slideRodDiameter+wallMinThickness*3; // TODO, change code to use above lengths instead


// #### Calculated values:  These can be or must be calculated from the input parameters
// crossRodLength = 1000;  // TODO define calculation to derive from slideRod dims.
