// #################################################################
// Print, View, and Cutaway Views for
// 6mm GT2 Belt over 624zz bearing
// #################################################################

include <libraries/BeltOverBearingAdapter.scad>;

bearingInsideDiameter = 4;
bearingOutsideDiameter = 13;
bearingWidth = 5;
bearingCaptureDepth = 1;
beltWidth = 6;
beltWidthGap = 0.4;
beltThickness = 1.5;
beltTravelDiameter = bearingOutsideDiameter + bearingCaptureDepth*3 ;
edgeWallThickness = 1;
pulleyWidth = max(bearingWidth,beltWidth+beltWidthGap) + edgeWallThickness*2;
pulleyDiameter = beltTravelDiameter + beltThickness*2;
printTolerance = 0.1;


module 624_GT2_BeltOverBearingAdapterPrint() {
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


module 624_GT2_BeltOverBearingAdapterView() {
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



module 624_GT2_BeltOverBearingAdapterViewCutaway() {
	difference() {
		624_GT2_BeltOverBearingAdapterView(
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
