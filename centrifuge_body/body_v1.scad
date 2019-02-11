/*

 OpenSCAD Microfuge body

 // inspired by: http://derisilab.ucsf.edu/index.php?3D=130
                 original design by Charlie Kim

 Mark Stenglein, 1.28.2018

 TODO: make this model parametric

*/


// this variable controls the resolution of the model
// decrease for coarser
$fn=100;

// these points define the cross-section of the rotor that will be rotated to form the circular body
// this also includes the central hole through which the top of the motor will pass
body_points=[ [15.5,0], [64,0], [64,50], [45,70], [42.17, 67.17], [60,50], [60,4], [23,4], [19.5, 30], [19.5, 47],
              [5.4, 47], [5.4, 44], [15.5, 44], [15.5, 0] ];

difference()
{

   // union to add cfuge body to the button mounting cube
   union()
   {
   
      // This difference will subtract the screw holes and slot for the wiring
      difference()
      {
         // this rotate extrude will make the circular cfuge body
         rotate_extrude()
         {
            // the body x-section
            polygon(body_points);
         } 
      
         // holes for motor screws
         // 15.5 mm offset on centers
         translate([7.75,0,43])
         cylinder(h=5, r1=2, r2=2, center=false);
         translate([-7.75,0,44])
         cylinder(h=5, r1=2, r2=2, center=false);
      
      
      } // end cfuge body difference
      
      // make the cube into which the button will mount
      translate([-83.5,-10,0])
      difference()
      {
         // rounded cube
         miniround ([20,20,35], 1.5);
         // this cylinder is hole through which button passes
         translate([10,10,33])
         cylinder (h=5, r1=6.3, r2=6.3, center=false);
         // this hexagon will secure the nut for mounting button...
         translate([10,10,27])
         cylinder(h=6.1, d1=16.2, d2=16.2, center=false, $fn=6);
         // this cube hollows out the overall mounting cube
         translate([1.25,1.25,-1])
         cube([17,17,31]);
      } // end difference for button mount
   
   } // end union
   
   // make a 8x8mm slot along bottom for the wiring
   translate([-74, -3, 2.5])
   cube([138, 8, 8]);

} // end difference (slot)


// this module will make a cube w/ rounded edges on the sides...
// from: https://www.thingiverse.com/thing:9347 by WilliamAAdams
// makes a cube w/ rounded corners...
module miniround(size, radius)
{
   $fn=50;
   x = size[0]-radius/2;
   y = size[1]-radius/2;

   minkowski()
   {
       cube(size=[x,y,size[2]]);
       cylinder(r=radius);
       // Using a sphere is possible, but will kill performance
       //sphere(r=radius);
   }
}




