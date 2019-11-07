/*

A tube insert for 1/8" ID 1/4" OD tubing
for inserting into a swagelok connector
Mark Stenglein, 11.27.2018

*/


// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=50;


// dimensions in mm -- modify these to change size 
base_diameter = 0.25 * 25.4;
base_height = 1;   

insert_diameter = 0.125 * 25.4 * 1.05; // make it a bit bigger than ID
insert_inner_diameter = insert_diameter * 0.6;
insert_height = 13;

part();

module part()
{
   difference()
   {
      union()
      {
         linear_extrude(height=base_height)
         circle(d=base_diameter);

         linear_extrude(height=insert_height)
         circle(d=insert_diameter);
      }
      linear_extrude(height=insert_height*1.1)
      circle(d=insert_inner_diameter);
   }
   
}

