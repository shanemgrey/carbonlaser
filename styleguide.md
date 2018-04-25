# Style Guide for coding project Carbon Laser

## File naming

 - camelCase with the first letter always lower case and each word after Upper

 - Left to right, most significant to least.  

The name of the file will usually be the full name of the assembly or sub assembly that will be created from it.

The file may have many parts to print.  Each of those may optionally be split out to their own files, and included in the full assembly file as a complete set of parts that by logic must all work together.

Sub assembly files should start with the parent assembly name unless they are a generic part that is used in multiple assemblies

**Example:**

```
allenBolt8x20.scad
slideCarriageStringAttachment.scad
slideCarriageBeltAttachment.scad
```

## Variable naming

 - camelCase with the first letter always lower case and each word after Upper

 - Left to right, most significant to least.  

**Example:**

```
slideCarriageSocketDepthMin = 10;
```

```
<assemblyName><attribute><dimension><modifier>
```

The assemblyName should be the least significant portion of the project necessary to discern it from the other portions.  It may be a single word, or multiple words together in camelCase.

A slideCarriage consists of many parts, some printed, other attached like screws and tape.  But it's clear which assembly of parts is being called to attention

The attribute should be a clear descriptive name of which part of the assembly that is having a dimension defined. It may be a single word, or multiple words together in camelCase.

The dimension should be a standardized name for a single dimension
 - Length
 - Width
 - Depth
 - Radius
 - Diameter
 - Thickness

The modifier is optional and is used for identifying if the value is a min/max etc.

## Module naming

 - PascalCase with all words capitalized

 - Left to right optional assembly name, optional sub-assembly name, optional function being performed

 - Descriptive comment above the module

**Examples:**

```
// The whole part shown as assembled, but not positioned for printing.  Use
// the print version when everything looks right
SlideCarriage() { ...

// Simple tube to test any cylinder fit
TestDiameterFit(slideRodDiameter, slideCarriageSocketDepthMin) { ...

 // Multiple tubes to test fits of cylinders and screws inserted, positioned for print
SlideCarriageTestDiameterFit() { ...

// The part without holes
SlideCarriageSolids() { ...

// The holes differenced out of the part
SlideCarriageCutouts() { ...
```

## Code layout

The goal of the code layout is to make the most frequently needed code be closer to the top, while maintaining a logical grouping.

1.) Each file should have a descriptive comment block at top in this form.

```
// #################################################################
// slideCarriage
// The carriage that connects to the drive cable or belt, and
// accepts one end of a cross rod
// #################################################################
```

2.) Included libraries and the global parameters.

```
include <nutsandbolts.scad>;
include <parameters.scad>;
```

3.) Calls to modules in the file which can be commented or enabled as needed.

```
//////////////////////////
// Print to test fit critical parts and tweak parameters
//////////////////////////
// SlideCarriageTestDiameterFit();


////////////////////////////////////////////////////
// Print these if everything looks like it will fit
////////////////////////////////////////////////////
// translate([-socketDepth*2,0,socketDepth/2])
// rotate([0,90,0])
// SlideCarriageTop();
//
// translate([0,0,cubeHeight/2])
// rotate([0,180,0])
// SlideCarriageMiddle();
//
// translate([socketDepth*1.5,0,cubeHeight/2])
// SlideCarriageBottom();
```

4.) File level parameters

```
// Additional file level parameters
specialCubeLength = slideCarriageLength;
specialCubeWidth = max(slideRodDiameter + (wallThicknessMin * 4),slideCarriageSocketDepthMin) ;
specialCubeHeight = slideRodDiameter + (wallThicknessMin * 2);
```

5.) Full assembly modules

Module code blocks should be top to bottom in order of most full assembly to smallest part of the complete assembly.  

This works fine in OpenSCAD because it loads all modules and doesn't care what order they are defined in.  

The advantage is that the programmer can quickly get to the most high level code, and dig in deeper to the parts that make it up as needed.

6.) Sub assembly modules

These modules will usually not be called directly to render or print.  They will be called in the parent modules to abstract away some details, or to be reused in multiple places.
