/*

 Sidewalls for ethoscope

 See: https://gilestrolab.github.io/ethoscope/

 The available parts were too thick when printed on our lulzbot taz printer, hence this redesign.

 Mark Stenglein, 3.6.2020 

*/


// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=50;

tab_width=14;
tab_height=2.65;
small_side_space = 30;
large_side_space = 40;
short_side_offset = (large_side_space - small_side_space)/2;
part_length = 135;
part_width = tab_width + tab_width + large_side_space;


// these points define a polygon of the cross-section of the gel tray
// this will be linear extruded...
cross_section_points = [ 
[0,0], 
[0, tab_width],
[25, tab_width],
[40, part_width/2],
[25, part_width-tab_width],
[0, part_width-tab_width],
[0, part_width],
[25, part_width],
[(part_length*0.4), (part_width*0.6)],
[(part_length*0.6), (part_width*0.6)],
[(part_length-25), part_width-short_side_offset],
[part_length, part_width-short_side_offset],
[part_length, part_width-short_side_offset-tab_width],
[part_length-25, part_width-short_side_offset-tab_width],
[(part_length*0.7), (part_width/2)],
[(part_length-25), short_side_offset+tab_width],
[part_length, short_side_offset+tab_width],
[part_length, short_side_offset],
[part_length-25, short_side_offset],
[(part_length*0.6), (part_width*0.4)],
[(part_length*0.4), (part_width*0.4)],
[25,0],
[0,0]];


circle_diameter = 3.1;
circle_offset = 1.75 + (circle_diameter/2); 

part();


module part()
{
   // this linear extrude will make the body of the gel tray
   linear_extrude(height=tab_height)
   {
      // subtract little holes
      difference()
      {
         union()
         {
            // this polygon defines the tray's x-section
            polygon(cross_section_points);
            // a circle in the middle
            difference()
            {
               translate([part_length/2, part_width/2,0])
               circle(r=part_width/2.5);
               translate([part_length/2, part_width/2,0])
               circle(r=part_width/4.2);
            }
         }

         // 4 little holes
         translate([circle_offset, tab_width/2, 0])
         circle(d = circle_diameter);
         translate([circle_offset, tab_width + large_side_space + tab_width/2, 0])
         circle(d = circle_diameter);
         translate([part_length-circle_offset, short_side_offset + tab_width/2, 0])
         circle(d = circle_diameter);
         translate([part_length-circle_offset, short_side_offset + tab_width + small_side_space + tab_width/2, 0])
         circle(d = circle_diameter);
      }
   } 
   
}


