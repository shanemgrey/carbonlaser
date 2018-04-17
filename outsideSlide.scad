// T-Slide for connecting stationary rod end to slide perpendicular on another rod

qualityFn = 100;

slideRodLength = 1000;
slideRodDiameter = 12;

slideLength = 100;

minSocketDepth = 20;

movingRodDiameter = 18;

printWallThickness = 3;
teflonTapeThickness = 0.1;


screwHeadDiameter = 4;
screwShaftDiameter = 3;
screwThreadDiameter = 2.5;

partSplitWidth = 1;

cubeLength = slideLength;
cubeWidth = max(slideRodDiameter + (printWallThickness * 4),minSocketDepth) ;
cubeHeight = slideRodDiameter + (printWallThickness * 2);

socketDepth = max(slideRodDiameter + (printWallThickness * 4),minSocketDepth) ;

totalScrewLength = slideRodDiameter+printWallThickness*3;


//////////////////////////
// Test fit with these
//////////////////////////
// testSlideRodDiameter();
//
// translate([-socketDepth*1.5,0,0])
// testMovingRodDiameter();
//
// translate([-socketDepth*3,0,0])
// testScrewFit();

////////////////////////////////////////////////////
// Print these if everything looks like it will fit
////////////////////////////////////////////////////
translate([-socketDepth*2,0,socketDepth/2])
rotate([0,90,0])
tSlidePartTop();

translate([0,0,cubeHeight/2])
rotate([0,180,0])
tSlidePartMiddle();

translate([socketDepth*1.5,0,cubeHeight/2])
tSlideBottom();


///////////////////////////////////////
// Visualize finished parts with these
///////////////////////////////////////
// tSlide();
// tSlidePartTop();
// tSlidePartMiddle();
// tSlideBottom();
// tSlideCutouts();
// sectionedView();

module testSlideRodDiameter () {
  difference () {
    cylinder(d=slideRodDiameter + printWallThickness*2 , h=8, center=true, $fn=qualityFn);
    cylinder(d=slideRodDiameter, h=9, center=true, $fn=qualityFn);
  }
}

module testMovingRodDiameter () {
  difference () {
    cylinder(d=movingRodDiameter + printWallThickness*2 , h=8, center=true, $fn=qualityFn);
    cylinder(d=movingRodDiameter, h=9, center=true, $fn=qualityFn);
  }
}

module testScrewFit () {
  difference () {
    cube([screwHeadDiameter*2, screwHeadDiameter*2, totalScrewLength/3*2], center=true);
    screwHole();
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
    translate([0,0,cubeHeight/4 + partSplitWidth/4])
    cube([cubeWidth+0.01, cubeLength+0.01, cubeHeight/2 - partSplitWidth/2], center=true);
  }
}

module tSlideBottom () {
  // color("yellow")
  intersection() {
    tSlide();
    translate([0,0,-(cubeHeight/4 + partSplitWidth/4)])
    cube([cubeWidth+0.01, cubeLength+0.01, cubeHeight/2 - partSplitWidth/2], center=true);
  }
  // difference() {
  //   tSlide();
  //   translate([0,0,(slideRodDiameter*3 - partSplitWidth)/2])
  //   cube([cubeWidth*2, slideLength+1, slideRodDiameter*3], center=true);
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
        cylinder(d=slideRodDiameter + (printWallThickness * 2), h=slideLength, center=true, $fn=qualityFn);
        // }
        translate([-cubeWidth/2, -cubeLength/2, -cubeHeight/2])
        roundedBox ([cubeWidth, cubeLength, cubeHeight], printWallThickness, true, $fn=40);
        // cube ([cubeWidth, cubeLength, cubeHeight]);


      // color("blue")
        hull() {
          cube([cubeWidth, socketDepth+printWallThickness*2, cubeHeight], center=true);
          translate([0, 0,movingRodDiameter+printWallThickness])
          rotate([0,90,0])
          cylinder(d=movingRodDiameter + (printWallThickness * 2), h=socketDepth, center=true, $fn=qualityFn);
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
      cylinder(d=slideRodDiameter + teflonTapeThickness, h=slideLength+1, center=true, $fn=qualityFn);

      // cut socket hole
      translate([0, 0,(slideRodDiameter+movingRodDiameter)/2+printWallThickness*2])
      rotate([0,90,0])
      cylinder(d=movingRodDiameter, h=socketDepth+1, center=true, $fn=qualityFn);


      // cut holes for top socket attachment
      rotate ([0,180,0]){
        translate([(slideRodDiameter + printWallThickness*1.5)/2, (movingRodDiameter + printWallThickness*1.5)/2, -printWallThickness]) {
        screwHole();
        }
        translate([-((slideRodDiameter + printWallThickness*1.5)/2), (movingRodDiameter + printWallThickness*1.5)/2, -printWallThickness]) {
        screwHole();
        }
        translate([(slideRodDiameter + printWallThickness*1.5)/2, -((movingRodDiameter + printWallThickness*1.5)/2), -printWallThickness]) {
        screwHole();
        }
        translate([-((slideRodDiameter + printWallThickness*1.5)/2), -((movingRodDiameter + printWallThickness*1.5)/2), -printWallThickness]) {
        screwHole();
        }
      }

      // cut holes for clamp screws
        translate([slideRodDiameter/2 + printWallThickness, -slideLength/2.5,cubeHeight/2-printWallThickness])
        screwHole();

        translate([slideRodDiameter/2 + printWallThickness, -slideLength/5,cubeHeight/2-printWallThickness])
        screwHole();

        translate([slideRodDiameter/2 + printWallThickness, slideLength/2.5,cubeHeight/2-printWallThickness])
        screwHole();

        translate([slideRodDiameter/2 + printWallThickness, slideLength/5,cubeHeight/2-printWallThickness])
        screwHole();

        translate([-(slideRodDiameter/2 + printWallThickness), -slideLength/2.5,cubeHeight/2-printWallThickness])
        screwHole();

        translate([-(slideRodDiameter/2 + printWallThickness), -slideLength/5,cubeHeight/2-printWallThickness])
        screwHole();

        translate([-(slideRodDiameter/2 + printWallThickness), slideLength/2.5,cubeHeight/2-printWallThickness])
        screwHole();

        translate([-(slideRodDiameter/2 + printWallThickness), slideLength/5,cubeHeight/2-printWallThickness])
        screwHole();
    // }
  // }
  }

module sectionedView () {
  // Cut section temporarily to view screw channel inside
  difference() {
    union() {
      tSlidePartTop();
      tSlidePartMiddle();
      tSlideBottom();
    }
    tSlideCutouts();
    translate([-socketDepth/2, -slideLength/2 -((movingRodDiameter + printWallThickness*1.5)/2),0])
    cube([socketDepth+1,slideLength,socketDepth+1], center=true);
    translate([-socketDepth/2, (socketDepth/2+0)+slideLength/2.5,0])
    cube([socketDepth+1,socketDepth+1,socketDepth+1], center=true);
  }
}

module screwHole() {
  render() {
    translate([0,0,totalScrewLength/2])
    cylinder(d=screwHeadDiameter, h=totalScrewLength, center=true, $fn=qualityFn);
    translate([0,0,(totalScrewLength)/2-slideRodDiameter/2 - partSplitWidth])
    cylinder(r1=screwShaftDiameter/2, r2=screwShaftDiameter/2, h=totalScrewLength, center=true, $fn=qualityFn);
    translate([0,0,(totalScrewLength)/2-slideRodDiameter/2 - movingRodDiameter/2])
    cylinder(d=screwThreadDiameter, h=totalScrewLength, center=true, $fn=qualityFn);
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
