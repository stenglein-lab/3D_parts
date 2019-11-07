/*

 3D microbes

 Mark Stenglein, 3.29.2018 

*/


// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=25;


// uncomment one of these to render
// optionally pass in diameter and height for virus
// virus();
// optionally pass in length and height for bacterium
// bacterium();
bacterium(100, 10);





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
   linear_extrude(height = length*1.25, convexity = 10,  twist = -720)
   translate([(height/5),0,0])
   circle(r = length / 12);
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


