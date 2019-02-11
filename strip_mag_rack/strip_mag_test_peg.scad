/*

 A magnetic rack for 8-well strip tubes

 Mark Stenglein, 10.10.2018

*/


// include <nuts_and_bolts_v1.95.scad>

// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=50;


// dimensions in mm -- modify these to change size 
base_length = 0;
base_width = 24;
base_height = 11.5;

end_length = 12;


// spacer_od = (3/8)*2.54*10;
hole_diameter = 6.65;  // empirically determined 

holes_x_offset = 5.5;
holes_y_offset = 3; 
hole_spacing = 9; // 96 well plate well-well spacing
strips_offset = 10;

magnet_gap_z_offset = 6;


magnet_gap_length = 122; // 2x 60 mm magnets
magnet_gap_width = 4.5; // for a 4mm wide magnet
magnet_gap_height = 10.5; // for a 10mm wide magnet

// test_pegs


// make it - blocked

difference()
{
   rack();
   // block();
}


// block will block of part of the part for test pringing
module block()
{
   translate([base_width*-0.05,base_length/3,base_height*-0.05])
   linear_extrude(height=base_height*1.1)
   square([base_width*1.1, base_length], false);
}

module rack()
{
   difference()
   {
      base();
      // holes();
      // %magnet_gap();
   }
}

module base()
{
   difference()
   {
      union()
      {
         linear_extrude(height=base_height)
         { 
            translate([0, 0, 0])
            square([base_width, base_length + end_length * 2], false);
         }
         peg_m();
      }
      peg_f();
   }
}

module holes ()
{
   for (row =[0:1:1])
   {
      for (hole =[0:1:13])
      {
         translate([0,0,-base_height*0.05])
         linear_extrude(height=base_height*1.1)
         {
            translate([holes_x_offset + (row * (base_width - (2 * holes_x_offset))) , (end_length + holes_y_offset + (hole * hole_spacing)), 0 ])
            circle(d=hole_diameter);
         }
      }
   }
}

module magnet_gap()
{
   translate([(base_width/2 - magnet_gap_width/2), end_length,  magnet_gap_z_offset])
   linear_extrude(height=magnet_gap_height)
   square([magnet_gap_width, magnet_gap_length], false);
   
}

module peg_m()
{
   translate([base_width/2, end_length/2, base_height])
   linear_extrude(height=base_height/2)
   circle(d=end_length/1.5);
}

module peg_f()
{
   translate([base_width/2, base_length + 1.5 * end_length, base_height/2])
   linear_extrude(height=base_height)
   circle(d=(end_length/1.5)*1.05);
}
