// #################################################################
// Outside Slide
// The carriage that connects to the drive cable or belt, and
// accepts one end of a cross rod
// #################################################################

// Include global parameters for the project
include <parameters.scad>;



//////////////////////////
// Test fit with these
//////////////////////////
// testSlideRodDiameter();
//
// translate([-socketDepth*1.5,0,0])
// testMovingRodDiameter();
//
// translate([-socketDepth*3,0,0])
// testBoltFit();

////////////////////////////////////////////////////
// Print these if everything looks like it will fit
////////////////////////////////////////////////////
// translate([-socketDepth*2,0,socketDepth/2])
// rotate([0,90,0])
// tSlidePartTop();
//
// translate([0,0,cubeHeight/2])
// rotate([0,180,0])
// tSlidePartMiddle();
//
// translate([socketDepth*1.5,0,cubeHeight/2])
// tSlideBottom();


///////////////////////////////////////
// Visualize finished parts with these
///////////////////////////////////////
// tSlide();
// tSlidePartTop();
// tSlidePartMiddle();
// tSlideBottom();
// tSlideCutouts();
sectionedView();


// Additional file level parameters
cubeLength = slideCarriageLength;
cubeWidth = max(slideRodDiameter + (wallMinThickness * 4),slideCarriageSocketDepthMin) ;
cubeHeight = slideRodDiameter + (wallMinThickness * 2);

socketDepth = max(slideRodDiameter + (wallMinThickness * 4),slideCarriageSocketDepthMin) ;




module testSlideRodDiameter () {
  difference () {
    cylinder(d=slideRodDiameter + wallMinThickness*2 , h=8, center=true, $fn=fnLargeDiameter);
    cylinder(d=slideRodDiameter, h=9, center=true, $fn=fnLargeDiameter);
  }
}

module testMovingRodDiameter () {
  difference () {
    cylinder(d=crossRodDiameter + wallMinThickness*2 , h=8, center=true, $fn=fnLargeDiameter);
    cylinder(d=crossRodDiameter, h=9, center=true, $fn=fnLargeDiameter);
  }
}

module testBoltFit () {
  difference () {
    cube([boltType1HeadDiameter*2, boltType1HeadDiameter*2, totalBoltLength/3*2], center=true);
    boltType1Hole();
  }
}

// module testSlideRodDiameter () {
//
// }

module tSlidePartTop () {
  // color("green")
  difference() {
    tSlide();
    cube([cubeWidth+0.01, cubeLength+0.01, cubeHeight+0.01], center=true);
  }
}

module tSlidePartMiddle () {
  // color("green")
  intersection() {
    tSlide();
    translate([0,0,cubeHeight/4 + slideSplitWidth/4])
    cube([cubeWidth+0.01, cubeLength+0.01, cubeHeight/2 - slideSplitWidth/2], center=true);
  }
}

module tSlideBottom () {
  // color("yellow")
  intersection() {
    tSlide();
    translate([0,0,-(cubeHeight/4 + slideSplitWidth/4)])
    cube([cubeWidth+0.01, cubeLength+0.01, cubeHeight/2 - slideSplitWidth/2], center=true);
  }
  // difference() {
  //   tSlide();
  //   translate([0,0,(slideRodDiameter*3 - slideSplitWidth)/2])
  //   cube([cubeWidth*2, slideCarriageLength+1, slideRodDiameter*3], center=true);
  // }
}

module tSlide () {
  difference() {
    tSlideSolids();
    tSlideCutouts();
  }
}

module tSlideSolids () {
    // render() {
      // union() {

      // full slide
        // union() {
        rotate([90,0,0])
        cylinder(d=slideRodDiameter + (wallMinThickness * 2), h=slideCarriageLength, center=true, $fn=fnLargeDiameter);
        // }
        translate([-cubeWidth/2, -cubeLength/2, -cubeHeight/2])
        roundedBox ([cubeWidth, cubeLength, cubeHeight], wallMinThickness, true, $fn=40);
        // cube ([cubeWidth, cubeLength, cubeHeight]);


      // color("blue")
        hull() {
          cube([cubeWidth, socketDepth+wallMinThickness*2, cubeHeight], center=true);
          translate([0, 0,crossRodDiameter+wallMinThickness *2])
          rotate([0,90,0])
          cylinder(d=crossRodDiameter + (wallMinThickness * 2), h=socketDepth, center=true, $fn=fnLargeDiameter);
        }

    // }
  // }
  }



  module tSlideCutouts () {

    // Cut out the rods and section the tubes
    // render() {
      // union() {

      // cut slide hole
      rotate([90,0,0])
      cylinder(d=slideRodDiameter + teflonTapeThickness, h=slideCarriageLength+1, center=true, $fn=fnLargeDiameter);

      // cut socket hole
      translate([0, 0,(slideRodDiameter+crossRodDiameter)/2+wallMinThickness*2])
      rotate([0,90,0])
      cylinder(d=crossRodDiameter, h=socketDepth+1, center=true, $fn=fnLargeDiameter);


      // cut holes for top socket attachment
      rotate ([0,180,0]){
        translate([(slideRodDiameter + wallMinThickness*1.5)/2, (crossRodDiameter + wallMinThickness*1.5)/2, -wallMinThickness]) {
        boltType1Hole();
        }
        translate([-((slideRodDiameter + wallMinThickness*1.5)/2), (crossRodDiameter + wallMinThickness*1.5)/2, -wallMinThickness]) {
        boltType1Hole();
        }
        translate([(slideRodDiameter + wallMinThickness*1.5)/2, -((crossRodDiameter + wallMinThickness*1.5)/2), -wallMinThickness]) {
        boltType1Hole();
        }
        translate([-((slideRodDiameter + wallMinThickness*1.5)/2), -((crossRodDiameter + wallMinThickness*1.5)/2), -wallMinThickness]) {
        boltType1Hole();
        }
      }

      // cut holes for clamp boltType1s
      // TODO: Make this an iteration such that slide length determines number of holes and positioning
      // This would allow for better dynamic resizing of the parts
        translate([slideRodDiameter/2 + wallMinThickness, -slideCarriageLength/2.5,cubeHeight/2-wallMinThickness])
        boltType1Hole();

        translate([slideRodDiameter/2 + wallMinThickness, -slideCarriageLength/5,cubeHeight/2-wallMinThickness])
        boltType1Hole();

        translate([slideRodDiameter/2 + wallMinThickness, slideCarriageLength/2.5,cubeHeight/2-wallMinThickness])
        boltType1Hole();

        translate([slideRodDiameter/2 + wallMinThickness, slideCarriageLength/5,cubeHeight/2-wallMinThickness])
        boltType1Hole();

        translate([-(slideRodDiameter/2 + wallMinThickness), -slideCarriageLength/2.5,cubeHeight/2-wallMinThickness])
        boltType1Hole();

        translate([-(slideRodDiameter/2 + wallMinThickness), -slideCarriageLength/5,cubeHeight/2-wallMinThickness])
        boltType1Hole();

        translate([-(slideRodDiameter/2 + wallMinThickness), slideCarriageLength/2.5,cubeHeight/2-wallMinThickness])
        boltType1Hole();

        translate([-(slideRodDiameter/2 + wallMinThickness), slideCarriageLength/5,cubeHeight/2-wallMinThickness])
        boltType1Hole();
    // }
  // }
  }

module sectionedView () {
  // Cut section temporarily to view boltType1 channel inside
  difference() {
    union() {
      tSlidePartTop();
      tSlidePartMiddle();
      tSlideBottom();
    }
    tSlideCutouts();
    translate([-socketDepth/2, -slideCarriageLength/2 -((crossRodDiameter + wallMinThickness*1.5)/2),0])
    cube([socketDepth+1,slideCarriageLength,socketDepth+1], center=true);
    translate([-socketDepth/2, (socketDepth/2+0)+slideCarriageLength/2.5,0])
    cube([socketDepth+1,socketDepth+1,socketDepth+1], center=true);
  }
}

module boltType1Hole() {
  render() {
    translate([0,0,totalBoltLength/2])
    cylinder(d=boltType1HeadDiameter, h=totalBoltLength, center=true, $fn=fnSmallDiameter);
    translate([0,0,(totalBoltLength)/2-slideRodDiameter/2 - slideSplitWidth])
    cylinder(r1=boltType1ShaftDiameter/2, r2=boltType1ShaftDiameter/2, h=totalBoltLength, center=true, $fn=fnSmallDiameter);
    translate([0,0,(totalBoltLength)/2-slideRodDiameter/2 - crossRodDiameter/2])
    cylinder(d=boltType1ThreadDiameter, h=totalBoltLength, center=true, $fn=fnSmallDiameter);
  }
}

module roundedBox(size, radius, sidesonly) {
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
