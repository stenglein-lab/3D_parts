/*

 Bio-Rad style Gel tray 

 Mark Stenglein, 2.9.2018 

*/


// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=25;


// dimensions in mm -- modify these to change size of gel
full_length = 100;
full_width = 84;
full_height = 25;
tray_width = 70;
bottom_thickness = 5.8;
wall_thickness = 3.3; // thickness of walls and overhang
overhang_width = 11;

// where to position gaps for comb inserts

// fractional positions along length of tray to make little holes for 
// comb to insert
gap_positions = [ 0.10, 0.42, 0.55, 0.87]; 
// size of gaps in mm
gap_width  = 3.3;
gap_length = 3.3;

// these points define a polygon of the cross-section of the gel tray
// this will be linear extruded...
cross_section_points = [ 
[0,full_height], 
[overhang_width, full_height],
[overhang_width, bottom_thickness],
[(full_width-overhang_width), bottom_thickness],
[(full_width-overhang_width), full_height],
[(full_width-overhang_width), full_height],
[full_width, full_height],
[full_width, (full_height-wall_thickness)],
[(full_width-overhang_width+wall_thickness), (full_height-wall_thickness)],
[(full_width-overhang_width+wall_thickness), 0],
[(overhang_width-wall_thickness), 0],
[(overhang_width-wall_thickness), (full_height - wall_thickness)],
[0, (full_height - wall_thickness)],
[0,full_height] ]; 

tray();
// virus();
// bacterium();


module tray()
{
   // This difference will subtract the comb peg gaps
   difference()
   {
      difference()
      {
         // this translate and rotate orient the part so the bottom is on the x-y plane and the corner is at the origin
         translate([0,full_length,0])
         rotate([90,0,0])
         // this linear extrude will make the body of the gel tray
         linear_extrude(height=full_length)
         {
            // this polygon defines the tray's x-section
            polygon(cross_section_points);
         } 
      
         // gaps on one side
         for (gap_start=gap_positions)
         {
            translate([0, gap_start*full_length,0])
                 cube([gap_width, gap_length, full_height*1.1]);
         }
         // gaps on the other side
         for (gap_start=gap_positions)
         {
            translate([full_width - gap_width, gap_start*full_length,0])
                 cube([gap_width, gap_length, full_height*1.1]);
         }
      } 
      
      /*
      // label it :)
      // text_positions=[0.27, 0.73];
      text_positions=[0.5];
      for (position = text_positions)
      {
         translate([overhang_width*0.9, full_length * position, full_height-2] )
         rotate([0,0,270])
         {
             linear_extrude(height = 4)
             {
                // text("StengleinLab.org", size=4, font = "Helvetica", valign="top", halign="center");
                text("S t e n g l e i n L a b . o r g", size=4, font = "Helvetica", valign="top", halign="center");
             }
         }
      }
      */
      
      label_widths = [(overhang_width * 0.6), full_width-(overhang_width * 0.6)]; 

      for (label_width = label_widths)
      {
         // bac_positions=[0.3, 0.6, 0.9];
         bac_positions=[0.27, 0.7];
         for (position = bac_positions)
         {
         
            translate([label_width, full_length * position, full_height] )
            rotate([0,0,270])
            bacterium();
         
         }
         
         // virus_positions=[0.1, 0.4, 0.7];
         virus_positions=[0.37, 0.8];
         for (position = virus_positions)
         {
         
            translate([label_width, full_length * position, full_height-1] )
            rotate([0,0,270])
            virus();
         }
      }
   
   }
}


module bacterium (length = 6, height= 2 )
{
   // cell body 
   rotate([90,0,0])
   union()
   {
      rotate([0,90,0])
      cylinder(h=length, center=true, r1=length/4, r2=length/4);
      translate([length/2,0,0])
      sphere(r=length/4, $fn=50);
      translate([-length/2,0,0])
      sphere(r=length/4, $fn=50);
   }

   // flagellum :)
   translate([length*0.35, 0, 0])
   rotate([90,0,90])
   linear_extrude(height = length*1.5, convexity = 10,  twist = -720)
   translate([(height/5),0,0])
   circle(r = length / 8);
}

module virus (diameter = 4, height= 2 )
{
   num_spikes=8;
   linear_extrude(height)
   union()
   {
      circle (d=diameter, $fn=50);
      for (angle =[0:360/num_spikes:359])
      {
         rotate([0,0,angle])
         union()
         {
         square([(diameter/num_spikes), (diameter*0.75)]);
         translate([(0.5 * diameter/num_spikes),diameter*0.75,0])
         circle(r=diameter/num_spikes);
         }
      }
   }
}


