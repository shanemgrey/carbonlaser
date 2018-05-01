$fn=50;

// default example values for typical 624 bearing and 6mm GT2 belt
// bearingInsideDiameter = 4;
// bearingOutsideDiameter = 13;
// bearingWidth = 5;
// bearingCaptureDepth = 1;
// beltWidth = 6;
// beltWidthGap = 1;
// beltThickness = 1.5;
// beltTravelDiameter = bearingOutsideDiameter + bearingCaptureDepth*3 ;
// edgeWallThickness = 1;
// pulleyWidth = max(bearingWidth,beltWidth+beltWidthGap) + edgeWallThickness*2;
// pulleyDiameter = beltTravelDiameter + beltThickness*2;
// printTolerance = 0.1;

// BeltOverBearingAdapterViewCutaway(
// 	bearingInsideDiameter,
// 	bearingOutsideDiameter,
// 	bearingWidth,
// 	bearingCaptureDepth,
// 	beltWidth,
// 	beltWidthGap,
// 	beltThickness,
// 	beltTravelDiameter,
// 	edgeWallThickness,
// 	pulleyWidth,
// 	pulleyDiameter,
// 	printTolerance
// );

// BeltOverBearingAdapterPrint(
// 	bearingInsideDiameter,
// 	bearingOutsideDiameter,
// 	bearingWidth,
// 	bearingCaptureDepth,
// 	beltWidth,
// 	beltWidthGap,
// 	beltThickness,
// 	beltTravelDiameter,
// 	edgeWallThickness,
// 	pulleyWidth,
// 	pulleyDiameter,
// 	printTolerance
// );


module BeltOverBearingAdapterPrint(
	bearingInsideDiameter,
	bearingOutsideDiameter,
	bearingWidth,
	bearingCaptureDepth,
	beltWidth,
	beltWidthGap,
	beltThickness,
	beltTravelDiameter,
	edgeWallThickness,
	pulleyWidth,
	pulleyDiameter,
	printTolerance) {
		translate ([pulleyDiameter+2,0,0])
		BeltOverBearingAdapterSide1(
			bearingOutsideDiameter,
			bearingWidth,
			bearingCaptureDepth,
			beltWidth,
			beltWidthGap,
			beltThickness,
			beltTravelDiameter,
			edgeWallThickness,
			pulleyWidth,
			printTolerance
		);
		BeltOverBearingAdapterSide2(
			bearingOutsideDiameter,
			bearingWidth,
			bearingCaptureDepth,
			beltWidth,
			beltWidthGap,
			beltThickness,
			beltTravelDiameter,
			edgeWallThickness,
			pulleyWidth
		);
}


module BeltOverBearingAdapterView(
	bearingInsideDiameter,
	bearingOutsideDiameter,
	bearingWidth,
	bearingCaptureDepth,
	beltWidth,
	beltWidthGap,
	beltThickness,
	beltTravelDiameter,
	edgeWallThickness,
	pulleyWidth,
	pulleyDiameter,
	printTolerance) {
		BeltOverBearingAdapterSide1(
			bearingOutsideDiameter,
			bearingWidth,
			bearingCaptureDepth,
			beltWidth,
			beltWidthGap,
			beltThickness,
			beltTravelDiameter,
			edgeWallThickness,
			pulleyWidth,
			printTolerance
		);
		translate ([0,0,pulleyWidth])
		rotate([180,0,0])
		BeltOverBearingAdapterSide2(
			bearingOutsideDiameter,
			bearingWidth,
			bearingCaptureDepth,
			beltWidth,
			beltWidthGap,
			beltThickness,
			beltTravelDiameter,
			edgeWallThickness,
			pulleyWidth
	);

}



module BeltOverBearingAdapterViewCutaway(
	bearingInsideDiameter,
	bearingOutsideDiameter,
	bearingWidth,
	bearingCaptureDepth,
	beltWidth,
	beltWidthGap,
	beltThickness,
	beltTravelDiameter,
	edgeWallThickness,
	pulleyWidth,
	pulleyDiameter,
	printTolerance
) {
	difference() {
		BeltOverBearingAdapterView(
			bearingInsideDiameter,
			bearingOutsideDiameter,
			bearingWidth,
			bearingCaptureDepth,
			beltWidth,
			beltWidthGap,
			beltThickness,
			beltTravelDiameter,
			edgeWallThickness,
			pulleyWidth,
			pulleyDiameter,
			printTolerance
		);
		translate([0,0,-0.05])
		cube([pulleyDiameter,pulleyDiameter,pulleyDiameter+0.1]);
	}
}

// Glue inside the groove to attach AdapterSide2 with bearing captured inside
module BeltOverBearingAdapterSide1(
	bearingOutsideDiameter,
	bearingWidth,
	bearingCaptureDepth,
	beltWidth,
	beltWidthGap,
	beltThickness,
	beltTravelDiameter,
	edgeWallThickness,
	pulleyWidth,
	printTolerance) {
	difference() {
		union() {
			translate([0,0,(pulleyWidth-bearingWidth)/4])
			SimpleRing((bearingOutsideDiameter+beltTravelDiameter)/2+0.01, bearingOutsideDiameter-bearingCaptureDepth*2, (pulleyWidth-bearingWidth)/2);
			translate([0,0,(pulleyWidth-beltWidth-beltWidthGap)/4])
			SimpleRing(beltTravelDiameter+beltThickness*2, (bearingOutsideDiameter+beltTravelDiameter)/2, (pulleyWidth-beltWidth-beltWidthGap)/2);
		}
		translate([0,0,pulleyWidth/2+edgeWallThickness/2])
		SimpleRing(beltTravelDiameter+printTolerance, bearingOutsideDiameter-printTolerance, pulleyWidth);
	}
}

module BeltOverBearingAdapterSide2(
		bearingOutsideDiameter,
		bearingWidth,
		bearingCaptureDepth,
		beltWidth,
		beltWidthGap,
		beltThickness,
		beltTravelDiameter,
		edgeWallThickness,
		pulleyWidth) {
		translate([0,0,(pulleyWidth-bearingWidth)/4])
		SimpleRing((bearingOutsideDiameter+beltTravelDiameter)/2+0.01, bearingOutsideDiameter-bearingCaptureDepth*2, (pulleyWidth-bearingWidth)/2);
		translate([0,0,(pulleyWidth-beltWidth-beltWidthGap)/4])
		SimpleRing(beltTravelDiameter+beltThickness*2, (bearingOutsideDiameter+beltTravelDiameter)/2, (pulleyWidth-beltWidth-beltWidthGap)/2);
		translate([0,0,pulleyWidth/2-edgeWallThickness/4])
		SimpleRing(beltTravelDiameter+0.01, bearingOutsideDiameter, pulleyWidth-edgeWallThickness/2);
}


module SimpleRing(ringOuterDiameter, ringInnerDiameter, ringHeight) {
  difference() {
    cylinder(r=ringOuterDiameter/2, h=ringHeight, center=true);
    cylinder(r=ringInnerDiameter/2, h=ringHeight*1.05, center=true);
  }
}
