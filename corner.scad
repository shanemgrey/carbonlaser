include <parameters.scad>
// use of 2 bounding boxes made to cut 45 and eliminate extra "tab" length

//boardThickness // thickness of boards used for all sides
//screwThreadDiameter // Diameter of thread, used for hole sizing
//screwLength
//screwHeadDiameter // Diameter of screw head, used for countersinking
//screwHeadDepth // Depth of countersinking
//minStructuralThickness // Plastic min depth
//cornerSize // overall cube size for corner
//tabSize // how far out the tab sticks
//tabScrewDiameter // size of hole in tab
//mooringHoleDiameter



Body();

module Body(){

//un-comment for visual fasterner reference
    
//translate([cornerSize/2.4,cornerSize-cornerSize/3,minStructuralThickness]) rotate([0,0,0]) CountersinkDrilling();
//translate([cornerSize-cornerSize/3,cornerSize/2.4,minStructuralThickness]) rotate([0,0,0]) CountersinkDrilling();
//translate([cornerSize-cornerSize/3,cornerSize-screwHeadDepth,cornerSize*0.53]) rotate([90,0,0]) CountersinkDrilling();
//translate([cornerSize-screwHeadDepth,cornerSize-cornerSize/3,cornerSize*0.67]) rotate([0,-90,0]) CountersinkDrilling();    
 


intersection(){
    difference(){
    union(){
        cube(cornerSize,center = false);
         rotate([0,0,-45]) translate([-(mooringHoleDiameter + 2*minStructuralThickness+screwHeadDepth)/2,cornerSize/2,0]) {Tab();};
        };
   translate([-minStructuralThickness-screwHeadDepth,-minStructuralThickness-screwHeadDepth,minStructuralThickness+screwHeadDepth]) cube(cornerSize, center = false); 
        //drill holes
translate([cornerSize/2.4,cornerSize-cornerSize/3,minStructuralThickness]) rotate([0,0,0]) CountersinkDrilling();
translate([cornerSize-cornerSize/3,cornerSize/2.4,minStructuralThickness]) rotate([0,0,0]) CountersinkDrilling();
//translate([cornerSize-cornerSize/3,cornerSize-screwHeadDepth,cornerSize*0.53]) rotate([90,0,0]) CountersinkDrilling();
translate([cornerSize-screwHeadDepth,cornerSize-cornerSize/3,cornerSize*0.67]) rotate([0,-90,0]) CountersinkDrilling();    
        
        
        
         };  

        hull(){
        translate([cornerSize-minStructuralThickness-screwHeadDepth,0,0]) sphere(r=.005, center=true);
            translate([cornerSize,0,0]) sphere(r=.005, center=true);
        translate([cornerSize-minStructuralThickness-screwHeadDepth, cornerSize-minStructuralThickness-screwHeadDepth, cornerSize]) sphere(r=.005, center=true);
        translate([0,cornerSize-minStructuralThickness-screwHeadDepth,0]) sphere(r=.005, center=true);
            translate([0,cornerSize,0]) sphere(r=.005, center=true);
        translate([3*cornerSize,0,0]) sphere(r=.005, center=true);
        translate([3*cornerSize,0,cornerSize]) sphere(r=.005, center=true);
        translate([3*cornerSize, 3*cornerSize, cornerSize]) sphere(r=.005, center=true);
         translate([3*cornerSize, 3*cornerSize, 0]) sphere(r=.005, center=true);
        translate([0,3*cornerSize,0]) sphere(r=.005, center=true);
        translate([0,3*cornerSize,cornerSize]) sphere(r=.005, center=true);
        
};
    };
}

module Tab(){  
    difference(){
        hull(){
        cube([mooringHoleDiameter + 2*minStructuralThickness,1,minStructuralThickness], center = false);
           translate([mooringHoleDiameter/4+minStructuralThickness,cornerSize+mooringHoleDiameter/2,0]) scale([1,1,.45]) sphere(r=mooringHoleDiameter/2+minStructuralThickness, center=false);
        };
    translate([mooringHoleDiameter/4+minStructuralThickness,cornerSize+mooringHoleDiameter/2,-1]) cylinder(h=3*mooringHoleDiameter, d=mooringHoleDiameter, center=false);
    };
}

module CountersinkDrilling() {
     translate([0,0,-screwHeadDepth-3]) cylinder(h=screwHeadDepth+3, d=screwHeadDiameter+0.2, center = false);
        cylinder(d=screwThreadDiameter+0.2, h=screwLength);   
}