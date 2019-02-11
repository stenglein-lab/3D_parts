/*

 OpenSCAD Microfuge rotor

 Mark Stenglein, 1.21.2018

*/


// this variable controls the resolution of the model
// decrease for coarser
$fn=100;

// these points define the cross-section of the rotor that will be rotated to form the circular body
rotor_points=[ [0,23], [12,23], [12,17], [18,17], [30,5], [43,17], [45,15], [32,2], [28,2], [16,14], [0,14], [0,23] ];  

// these points define the central hole (into which the rotor will stick)
central_hole_points=[[0,23], [1.65,23], [1.65,17], [0,17]];

// This difference will make the holes from cylinders subtracted from the circular rotor body
difference()
{
   // this rotate extrude will make the circular rotor body
   rotate_extrude()
   {
      // this difference will subtract the central hole in the rotor body
      // and will do some misc. cleanup
      difference()
      {
         // union of parts making up central rotor body
         union()
         {
            // make the rotor x-section
            polygon(rotor_points);
            // these circles round out some edges
            translate([12,17])
            circle(r=6);
            translate([30,2])
            circle(r=2);
            translate([43,15])
            circle(r=2);
         }
         // these are difference objects that will be subtracted
         // the central hole
         polygon(central_hole_points);
   
         // 'erase' the too-big circle
         polygon([[0,0], [0,14], [16,14],[28,2], [28,0],[0,0]]);
      }

   } // end rotate extrude


// going to make the holes in the rotor using 8 cylinders

// math for the cylinders -- convert to polar coordinate system
// see: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#rotate

x= 20; y = 20; z = 20; // point coordinates of end of cylinder
length = norm([x,y,z]);  // radial distance
b = acos(z/length);      // inclination angle
c = atan2(y,x);          // azimuthal angle

// make the 8 cylinders that will be subtracted from the rotor (from the difference above)

tube_hole_d = 11.3;   // in mm - diameter of tube hole

// for loop will rotate the cyclinder azimuth 45˚ each time
for(i = [0 : 7 ])
   translate([0,0,-6.5])  
   rotate([0, b, (c+(i*45))])
   cylinder(h=length, r=(tube_hole_d/2));    // % at beginning of line will visualize cylinders 

} // end difference


