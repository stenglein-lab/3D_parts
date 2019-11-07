include <quickthread.scad>

width = 150;
length = 30;
thickness = 10;


difference() 
{

   cube ([width,length,thickness]);

   translate([width * 0.1, length * 0.5, -thickness * 0.25])
   %isoThread(d=14, pitch=1.5, h=thickness * 1.3, internal=false) ;
   // metric_thread (diameter=14, pitch=1.5, length=thickness * 1.3, internal=true);

   translate([width * 0.9, length * 0.5, -thickness * 0.25])
   // metric_thread (diameter=14, pitch=1.5, length=thickness * 1.3, internal=true);
   %isoThread(d=14, pitch=1.5, h=thickness * 1.3 , internal=false) ;

}



