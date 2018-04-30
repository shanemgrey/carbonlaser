// #################################################################
// Outside Slide
// The carriage that connects to the drive cable or belt, and
// accepts one end of a cross rod
// #################################################################

// Include global parameters for the project
include <parameters.scad>;

// Additional file level parameters
slideCarriageWidth = max(slideRodDiameter + (boltType1HeadDiameter*2+wallThicknessMin * 2),slideCarriageSocketDepthMin ) ;
slideCarriageHeight = slideRodDiameter + (wallThicknessMin * 2);

socketDepth = slideCarriageWidth;

View();
// PrintTestFitParts();
// PrintParts();

///////////////////////////////////////
// Visualize finished parts with these
///////////////////////////////////////
// SlideCarriage();
// SlideCarriagePartTop();
// SlideCarriagePartMiddle();
// SlideCarriageBottom();
// SlideCarriageCutouts();
// SectionedView();

// translate([-socketDepth*1.5,0,0])
// BoltType1Hole();
// translate([-socketDepth*2.5,0,0])
// BoltType1();

module View () {
  SectionedView();
}

module PrintTestFitParts () {
  SlideCarriageRodDiameterTest();
  translate([-socketDepth*1.5,0,0])
  MovingRodDiameterTest();
  translate([-socketDepth*3,0,0])
  BoltFitTest();
}

module PrintParts () {
  translate([-socketDepth*2,0,socketDepth/2])
  rotate([0,90,0])
  SlideCarriagePartTop();
  translate([0,0,slideCarriageHeight/2])
  rotate([0,180,0])
  SlideCarriagePartMiddle();
  translate([socketDepth*1.5,0,slideCarriageHeight/2])
  SlideCarriageBottom();
}



module SlideCarriageRodDiameterTest () {
  difference () {
    cylinder(d=slideRodDiameter + wallThicknessMin*2 , h=8, center=true, $fn=fnLargeDiameter);
    cylinder(d=slideRodDiameter, h=9, center=true, $fn=fnLargeDiameter);
  }
}

module MovingRodDiameterTest () {
  difference () {
    cylinder(d=crossRodDiameter + wallThicknessMin*2 , h=8, center=true, $fn=fnLargeDiameter);
    cylinder(d=crossRodDiameter, h=9, center=true, $fn=fnLargeDiameter);
  }
}

// Tests that the threads grab properly
module BoltThreadingTest () {
  difference () {
    cube([boltType1HeadHoleDiameter*2, boltType1HeadHoleDiameter*2, totalBoltLength/3*2], center=true);
    translate([0,0,slideCarriageHeight/2])
    BoltType1Hole();
  }
}
// Tests that the head and shaft fit easily
module BoltFitTest () {
  difference () {
    cube([boltType1HeadHoleDiameter*2, boltType1HeadHoleDiameter*2, totalBoltLength/3*2], center=true);
    translate([0,0,slideCarriageHeight/2])
    BoltType1Hole();
  }
}

module SlideCarriagePartTop () {
  // color("green")
  difference() {
    SlideCarriage();
    cube([slideCarriageWidth+0.01, slideCarriageLength+0.01, slideCarriageHeight+0.01], center=true);
  }
}

module SlideCarriagePartMiddle () {
  // color("green")
  intersection() {
    SlideCarriage();
    translate([0,0,slideCarriageHeight/4 + slideCarriageSplitWidth/4])
    cube([slideCarriageWidth+0.01, slideCarriageLength+0.01, slideCarriageHeight/2 - slideCarriageSplitWidth/2], center=true);
  }
}

module SlideCarriageBottom () {
  // color("yellow")
  intersection() {
    SlideCarriage();
    translate([0,0,-(slideCarriageHeight/4 + slideCarriageSplitWidth/4)])
    cube([slideCarriageWidth+0.01, slideCarriageLength+0.01, slideCarriageHeight/2 - slideCarriageSplitWidth/2], center=true);
  }
  // difference() {
  //   SlideCarriage();
  //   translate([0,0,(slideRodDiameter*3 - slideCarriageSplitWidth)/2])
  //   cube([slideCarriageWidth*2, slideCarriageLength+1, slideRodDiameter*3], center=true);
  // }
}

module SlideCarriage () {
  difference() {
    SlideCarriageSolids();
    SlideCarriageCutouts();
  }
}

module SlideCarriageSolids () {
    // render() {
      // union() {

      // full slide
        // union() {
        rotate([90,0,0])
        cylinder(d=slideRodDiameter + (wallThicknessMin * 2), h=slideCarriageLength, center=true, $fn=fnLargeDiameter);
        // }
        translate([-slideCarriageWidth/2, -slideCarriageLength/2, -slideCarriageHeight/2])
        RoundedBox ([slideCarriageWidth, slideCarriageLength, slideCarriageHeight], wallThicknessMin, true, $fn=40);
        // cube ([slideCarriageWidth, slideCarriageLength, slideCarriageHeight]);


      // color("blue")
        hull() {
          cube([slideCarriageWidth, socketDepth+wallThicknessMin*2, slideCarriageHeight], center=true);
          translate([0, 0,crossRodDiameter+wallThicknessMin *2])
          rotate([0,90,0])
          cylinder(d=crossRodDiameter + (wallThicknessMin * 2), h=socketDepth, center=true, $fn=fnLargeDiameter);
        }

    // }
  // }
  }



  module SlideCarriageCutouts () {

    // Cut out the rods and section the tubes
    // render() {
      // union() {

      // cut slide hole
      rotate([90,0,0])
      cylinder(d=slideRodDiameter + teflonTapeThickness, h=slideCarriageLength+1, center=true, $fn=fnLargeDiameter);

      // cut socket hole
      translate([0, 0,(slideRodDiameter+crossRodDiameter)/2+wallThicknessMin*2])
      rotate([0,90,0])
      cylinder(d=crossRodDiameter, h=socketDepth+1, center=true, $fn=fnLargeDiameter);


      // cut holes for top socket attachment
      rotate ([0,180,0]){
        translate([(slideRodDiameter + boltType1HeadHoleDiameter + wallThicknessMin)/2, (crossRodDiameter + wallThicknessMin*1.5)/2, boltType1ShaftLength-(slideCarriageHeight)/2])
        #BoltType1Hole();

        translate([-((slideRodDiameter + boltType1HeadHoleDiameter + wallThicknessMin)/2), (crossRodDiameter + wallThicknessMin*1.5)/2, boltType1ShaftLength-(slideCarriageHeight)/2])
        #BoltType1Hole();

        translate([(slideRodDiameter + boltType1HeadHoleDiameter + wallThicknessMin)/2, -((crossRodDiameter + wallThicknessMin*1.5)/2), boltType1ShaftLength-(slideCarriageHeight)/2])
        #BoltType1Hole();

        translate([-((slideRodDiameter + boltType1HeadHoleDiameter + wallThicknessMin)/2), -((crossRodDiameter + wallThicknessMin*1.5)/2), boltType1ShaftLength-(slideCarriageHeight)/2])
        #BoltType1Hole();

      }

      // cut holes for clamp boltType1s
      // TODO: Make this an iteration such that slide length determines number of holes and positioning
      // This would allow for better dynamic resizing of the parts
        #translate([slideRodDiameter/2 + wallThicknessMin, -slideCarriageLength/2.5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();

        #translate([slideRodDiameter/2 + wallThicknessMin, -slideCarriageLength/5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();

        #translate([slideRodDiameter/2 + wallThicknessMin, slideCarriageLength/2.5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();

        #translate([slideRodDiameter/2 + wallThicknessMin, slideCarriageLength/5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();

        #translate([-(slideRodDiameter/2 + wallThicknessMin), -slideCarriageLength/2.5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();

        #translate([-(slideRodDiameter/2 + wallThicknessMin), -slideCarriageLength/5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();

        #translate([-(slideRodDiameter/2 + wallThicknessMin), slideCarriageLength/2.5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();

        #translate([-(slideRodDiameter/2 + wallThicknessMin), slideCarriageLength/5,boltType1ShaftLength+slideCarriageSplitWidth/2])
        BoltType1Hole();
    // }
  // }
  }

module SectionedView () {
  // Cut section temporarily to view boltType1 channel inside
  difference() {
    union() {
      SlideCarriagePartTop();
      SlideCarriagePartMiddle();
      SlideCarriageBottom();
    }
    SlideCarriageCutouts();
    translate([-socketDepth/2, -slideCarriageLength/2 -((crossRodDiameter + wallThicknessMin*1.5)/2),0])
    cube([socketDepth+1,slideCarriageLength,slideCarriageHeight*3], center=true);
    translate([-socketDepth/2, (socketDepth/2+0)+slideCarriageLength/2.5,0])
    cube([socketDepth+1,socketDepth+1,slideCarriageHeight*3], center=true);
  }
}

module BoltType1Hole() {
  render() {
    // translate([0,0,totalBoltLength/2])
    cylinder(d=boltType1HeadHoleDiameter, h=boltType1HeadHoleLength, center=false, $fn=fnSmallDiameter);
    translate([0,0,-boltType1ShaftHoleLength])
    cylinder(d=boltType1ShaftHoleDiameter, h=boltType1ShaftHoleLength, center=false, $fn=fnSmallDiameter);
    translate([0,0,-(boltType1ThreadHoleLength+boltType1ShaftHoleLength)])
    cylinder(d=boltType1ThreadHoleDiameter, h=boltType1ThreadHoleLength, center=false, $fn=fnSmallDiameter);
  }
}

module BoltType1() {
  render() {
    // translate([0,0,totalBoltLength/2])
    cylinder(d=boltType1HeadDiameter, h=boltType1HeadLength, center=false, $fn=fnSmallDiameter);
    translate([0,0,-boltType1ShaftLength])
    cylinder(d=boltType1ShaftDiameter, h=boltType1ShaftLength, center=false, $fn=fnSmallDiameter);
    translate([0,0,-(boltType1ThreadLength+boltType1ShaftLength)])
    cylinder(d=boltType1ThreadDiameter, h=boltType1ThreadLength, center=false, $fn=fnSmallDiameter);
  }
}

module RoundedBox(size, radius, sidesonly) {
        rot = [ [0,0,0], [90,0,90], [90,90,0] ];

        // Translate shape back to origin on corners
        translate((size - [0,0,0])/2)
        if (sidesonly) {
                cube(size - [2*radius,0,0], true);
                cube(size - [0,2*radius,0], true);
                // Full length cylinders on 4 edges
                for (x = [radius-size[0]/2, -radius+size[0]/2],
                     y = [radius-size[1]/2, -radius+size[1]/2]) {
                        translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
                }
        }
        else {
                cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
                cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
                cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);
                // Cylinders shortened and on all cube edges
                for (axis = [0:2]) {
                        for (x = [radius-size[axis]/2, -radius+size[axis]/2],
                             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
                                rotate(rot[axis])
                                translate([x,y,0])
                                cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
                        }
                }
                //sphere corners
                for (x = [radius-size[0]/2, -radius+size[0]/2],
                     y = [radius-size[1]/2, -radius+size[1]/2],
                     z = [radius-size[2]/2, -radius+size[2]/2]) {
                        translate([x,y,z]) sphere(radius);
                }
        }
}
