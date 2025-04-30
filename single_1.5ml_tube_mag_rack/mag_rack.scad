/*

 A magnetic rack for 1.5 ml tubes

 Mark Stenglein, 10.11.2018

 For use with K&J Magnetics magnets part number B842-N52

 Print the part with PLA or ABS.  Glue the magnet in place with superglue or epoxy.

*/


// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=50;


// dimensions in mm -- modify these to change size 
base_diameter = 40;
base_height = 3;

inner_diameter = 30;
inner_height = 35;
inner_thickness = 4;

top_height = 1;
tube_hole_diameter = 11.5;



// The part
union()
{
   base();
   inner();
   mag_face();
}


// circular base
module base()
{
  linear_extrude(height=base_height)
  { 
     circle(d=base_diameter);
  } 
}

// this is the middle of the part
module inner()
{
  translate([0, 0, base_height])
  difference()
  {
        linear_extrude(height=inner_height)
        { 
           circle(d=inner_diameter);
        }

	// these next 2 make rotated egg-shaped holes in the part
	// so you can see what's happening with your tube
        translate([0, 0, base_height+inner_height*0.4])
        resize(newsize=[inner_diameter*1.8,inner_diameter*0.55,inner_height * 0.9]) sphere(r=1,center=false);

        translate([0, 0, base_height+inner_height*0.4])
        resize(newsize=[inner_diameter*0.55,inner_diameter*1.8,inner_height * 0.9]) sphere(r=1,center=false);

	// notch out a bit for the magnet to fit
        translate([0,-5,base_height])
        cube([7,7,7],center=true);

	// make the tube hole in top
        translate([0,0,base_height+inner_height*0.7])
        linear_extrude(height=20)
        circle(d=tube_hole_diameter);

	// make an indent in bottom for the bottom of the tube
        translate([0,0,-base_height*0.3])
        linear_extrude(height=10)
        circle(d=6);
        
  }
}

// circular top with tube hole
module top()
{
  translate([0, 0, base_height + inner_height - top_height/2])
  linear_extrude(height=top_height*2)
  { 
     difference()
     {
        circle(d=inner_diameter);
     }
  }
}

// a helper function for measuring the hole measuring 
module hole_measure()
{
  translate([0, 0, base_height+inner_height])
  { 
     %circle(d=tube_hole_diameter);
  }
}

// this makes the little bit that holds the magnet 
module mag_face()
{
   bx = 10;
   by = 10;
   bz = 0;
   tx = 10;
   ty = 7;
   tz = 15;

   mag_x = 7;
   mag_y = 3;
   mag_z = 13;

   points=[[0,0,bz], [bx,0,bz], [bx,by,bz], [0,by,bz],
           [0,0,tz], [tx,0,tz], [tx,ty,tz], [0,ty,tz]];

   faces=  [[0,1,2,3],  // bottom
            [4,5,1,0],  // front
            [7,6,5,4],  // top
            [5,6,2,1],  // right
            [6,7,3,2],  // back
            [7,4,0,3]]; // left

    translate([-bx/2,-inner_diameter/2.2,base_height])
    difference()
    {
      polyhedron( points, faces );
      translate([(bx-mag_x)/2,by*0.8,(tz-mag_z)/2])
      // 25.01 is from arctan(7/15)
      rotate(a=10, v=[1,0,0])
      cube([mag_x, mag_y, mag_z]);
   }

}

// rotate specified angle a around point pt
module rotate_about_pt(a, pt) {
    translate(pt)
        rotate(a)
            translate(-pt)
                children();
}

