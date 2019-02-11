/*

 A magnetic rack for 8-well strip tubes
Mark Stenglein, 10.10.2018

*/


// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=50;


// dimensions in mm -- modify these to change size 
base_length = 122;
base_width = 24;
base_height = 11.5;

end_length = 12;


// spacer_od = (3/8)*2.54*10;
hole_diameter = 6.65;  // empirically determined 

holes_x_offset = 6;
holes_y_offset = 2.5; 
hole_spacing = 9; // 96 well plate well-well spacing
strips_offset = 10;

magnet_gap_z_offset = 5;

magnet_gap_length = 119; // 2x 60 mm magnets: they are a little shorter than spec.
magnet_gap_width = 3.3; // for a 3mm wide magnet
magnet_gap_height = 10.5; // for a 10mm wide magnet


difference()
{
   rack();

   // block() just masks out part of the part for test printing
   // block();
}


// block will block of part of the part for test printing
module block()
{
   translate([base_width*-0.05,base_length/3,base_height*-0.05])
   linear_extrude(height=base_height*1.1)
   square([base_width*1.1, base_length], false);
}

// main module for the part
module rack()
{
   difference()
   {
      base();
      holes();
      magnet_gap();
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
      side_gaps();
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
   translate([(base_width/2 - magnet_gap_width/2), (end_length+((base_length - magnet_gap_length)/2)),  magnet_gap_z_offset])
   linear_extrude(height=magnet_gap_height)
   square([magnet_gap_width, magnet_gap_length], false);
   
}

module peg_m()
{
   translate([base_width/2, end_length/2, base_height])
   linear_extrude(height=base_height/2)
   //  circle(d=end_length/1.5);
   square([base_width*0.7*0.9, end_length*0.6*0.9], true);
}

module peg_f()
{
   translate([base_width/2, base_length + 1.5 * end_length, base_height/2])
   linear_extrude(height=base_height)
   // circle(d=(end_length/1.5)*1.05);
   square([base_width*0.7, end_length*0.6], true);
}

module side_gaps()
{
   translate([-0.01, end_length, base_height/6])
   linear_extrude(height=base_height*6/6)
   square([base_width * 0.2, base_length],false);

   translate([base_width*0.8, end_length, base_height/6])
   linear_extrude(height=base_height*6/6)
   square([base_width, base_length],false);
}
