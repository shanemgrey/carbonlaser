// #################################################################
// EndSupportMotorSide
// The carriage that connects to the drive cable or belt, and
// accepts one end of a cross rod
// #################################################################

// Include global parameters for the project
include <parameters.scad>;
include <624_GT2_BeltOverBearingAdapter.scad>;

screwHoleInset = max(mountingScrewHeadDiameter/2, wallThicknessMin); // From corner of plate to center of hole

// The 624 bearing is 5mm wide, and the pulley is 9mm wide in total.
// So there needs to be a 2mm inset to reach the bearing center from the outside edge of the pulley
// Plus some gap to avoid rubbing
// Because of overhang angle needing to be kept to 45 or less, they don't quite reach and the pulleys will need 1mm spacers inside also.
pulleyBearingInset = 1 + motorSidePulleySideClearance;

view();
// print();




module view() {
  EndSupportMotorSide();
  // Show pulleys in place
  color("grey") {
    translate([motorSidePulleyMountTotalThickness/2+motorSidePulleySideClearance,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin])
    rotate([90,0,0])
    rotate([0,90,0])
    624_GT2_BeltOverBearingAdapterViewCutaway($fn=100);
    translate([-motorSidePulleyMountTotalThickness/2-motorSidePulleySideClearance,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin])
    rotate([0,270,0])
    624_GT2_BeltOverBearingAdapterViewCutaway($fn=100);
  }
  color("white")
  translate([0,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin])
  rotate([0,270,0])
  cylinder(r=2,h=30, center=true);
}

module print () {
  EndSupportMotorSide();
  translate([mountingPlateX,0,0])
  624_GT2_BeltOverBearingAdapterPrint($fn=100);
  translate([mountingPlateX,mountingPlateX,0])
  624_GT2_BeltOverBearingAdapterPrint($fn=100);
  translate([mountingPlateX,mountingPlateX*2,0]){
    PulleySpacerRings();
  }
  translate([mountingPlateX*2,mountingPlateX*2,0]){
    PulleySpacerRings();
  }
}

module EndSupportMotorSide(){
  //main flange and hull for mounting pulley/bearing
  difference(){
    EndSupportMotorSideSolids();
    EndSupportMotorSideCutouts();
  };
};

module EndSupportMotorSideSolids() {
    // Socket for Slide Rod
    cylinder(d=slideRodDiameter+2*wallThicknessMin, h=endSupportRodInsertionDepth, center=false, $fn=fnLargeDiameter);

    // Mounting Plate
    translate([0,motorSidePulleyEdgeDiameter/2,0])
    RoundedBox ([mountingPlateX, mountingPlateY, wallThicknessMin>mountingPlateZ?wallThicknessMin:mountingPlateZ], wallThicknessMin, sidesonly=true, center=true, $fn=fnSmallDiameter);

    // Pulley Brackets
    hull() {
      translate([0,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin])
      rotate([0,90,0])
      cylinder(d=motorSidePulleyBearingInsideDiameter+wallThicknessMin*2, h=motorSidePulleyMountTotalThickness, center=true, $fn=fnLargeDiameter);
      translate([0,(motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin)/2,(motorSidePulleyEdgeDiameter/2++wallThicknessMin)/2])
      cube([motorSidePulleyMountTotalThickness,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin], center=true);
    }
    translate([-motorSidePulleyMountTotalThickness/2+0.01,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin])
    rotate([0,270,0])
    // cylinder(r1=(motorSidePulleyBearingInsideDiameter2)/2, r2=(motorSidePulleyBearingInsideDiameter2)/2+pulleyBearingInset, h=pulleyBearingInset*2, center=false, $fn=fnLargeDiameter);
    cylinder(r2=(motorSidePulleyBearingInsideDiameter2)/2, r1=(motorSidePulleyBearingInsideDiameter2)/2+pulleyBearingInset, h=pulleyBearingInset, center=false, $fn=fnLargeDiameter);
    translate([motorSidePulleyMountTotalThickness/2-0.01,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin])
    rotate([0,90,0])
    cylinder(r2=(motorSidePulleyBearingInsideDiameter2)/2, r1=(motorSidePulleyBearingInsideDiameter2)/2+pulleyBearingInset, h=pulleyBearingInset, center=false, $fn=fnLargeDiameter);

}

module EndSupportMotorSideCutouts() {

  // Socket for Slide Rod
  cylinder(h=endSupportRodInsertionDepth+0.01, d=slideRodDiameter, center=false);

  // Screw Holes in Mounting Plate
  translate([0,motorSidePulleyEdgeDiameter/2,0])
  for (x = [mountingPlateX/2-screwHoleInset, -mountingPlateX/2+screwHoleInset],
       y = [mountingPlateY/2-screwHoleInset, -mountingPlateY/2+screwHoleInset]) {
          translate([x,y,0])
          cylinder(r=mountingScrewHoleDiameter/2, h=wallThicknessMin>mountingPlateZ?wallThicknessMin:mountingPlateZ+1, center=true, $fn=fnSmallDiameter);
  }

  // Hole for center of pulley mount
  translate([0,motorSidePulleyEdgeDiameter/2+slideRodDiameter+wallThicknessMin,motorSidePulleyEdgeDiameter/2++wallThicknessMin])
  rotate([0,90,0])
  cylinder(r=motorSidePulleyBearingInsideDiameter/2, h=motorSidePulleyMountTotalThickness+pulleyBearingInset*2+1, center=true, $fn=fnLargeDiameter);

}


// The space that one pulley would be situated in, leaving gaps except where pressed in the middle
module PulleySpacerRings() {
  for (y = [motorSidePulleyBearingInsideDiameter2+2, motorSidePulleyBearingInsideDiameter2*2+4]) {
    translate([0,y,0])
    difference() {
      cylinder(d=motorSidePulleyBearingInsideDiameter2+0.1, h=motorSidePulleySideClearance, center=true, $fn=fnLargeDiameter);
      cylinder(d=motorSidePulleyBearingInsideDiameter+0.1, h=motorSidePulleySideClearance+0.1, center=true, $fn=fnLargeDiameter);
    }
  }
}
//
// module PulleyOutsideRing() {
// 	SimpleRing(motorSidePulleyEdgeDiameter, motorSidePulleyBearingOutsideDiameter, beltThickness+beltThickness);
// 	// shoulder ring
// 	translate([0,0,-(pulley_inside_belt_height+pulley_shoulder_thickness)/2]) SimpleRing(pulley_shoulder_od, pulley_id-2, pulley_shoulder_thickness);
// }
//
// module PulleyInsideRing() {
// 	difference() {
// 	SimpleRing(pulley_shoulder_od, pulley_id-2, pulley_shoulder_thickness);
// 	translate([0,0,-(pulley_inside_belt_height+pulley_shoulder_thickness)/2]) SimpleRing(pulley_od, pulley_id, pulley_inside_belt_height+pulley_shoulder_thickness);
// 	}
// }
//
// module SimpleRing(ringOD, ringID, height) {
//   difference() {
//     cylinder(r=ringOD/2, h=height, center=true);
//     cylinder(r=ringID/2, h=height*1.05, center=true);
//   }
// }
module RoundedBox(size, radius, sidesonly=true, center=true) {
        rot = [ [0,0,0], [90,0,90], [90,90,0] ];

        // Translate shape back to origin on corners
        // translate((size - [0,0,0])/2)
        if (sidesonly) {
                cube(size - [2*radius,0,0], center);
                cube(size - [0,2*radius,0], center);
                // Full length cylinders on 4 edges
                for (x = [radius-size[0]/2, -radius+size[0]/2],
                     y = [radius-size[1]/2, -radius+size[1]/2]) {
                        translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
                }
        }
        else {
                cube([size[0], size[1]-radius*2, size[2]-radius*2], center=center);
                cube([size[0]-radius*2, size[1], size[2]-radius*2], center=center);
                cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=center);
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
