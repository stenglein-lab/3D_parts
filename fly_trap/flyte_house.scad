// Fruit fly bottle top trap that kind of looks like the white house
// This bottle cap fits on ULine jars catalog # S-9934

// designed by Mark Stenglein based on a previous trap designed by Shaun Cross

// This file includes code from the thread library,
// Copyright 2017 Dan Kirshner - dan_kirshner@yahoo.com,
// which is licensed under the GNU GPL v3.0.
// This library is available from::
// http://dkprojects.net/openscad-threads/

/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
*/


cap_radius = 63/2;      //according to U-line spec 

fly_exit_height = 25;   //how long the fly exit is
fly_exit = 15;          //starting radius of the linear extrude
fly_exit_scale = 0.133; //the scaling value (ending exit size from linear extrude)
fly_hole_scale = 0.1;   //the size of the hole that gets removed from the fly exit

// threads on cap (mm)
thread_pitch  = 4.23;
thread_length = 6.5;
thread_diam   = 60;

cap_height = 10;

weird_cap_height = 6;

// controls resolution
$fn=50;

// Dan Kirshner's thread library from:
// http://dkprojects.net/openscad-threads/
include <threads.scad>;

module make_all()
{
    union(){
        union(){
            difference(){
                make_cap();
                linear_extrude(height = 10)
                circle(fly_exit*0.75);};
                translate([0,0,0])
                difference() {
                linear_extrude(height = fly_exit_height, scale = fly_exit_scale)
                    circle(fly_exit);
                    fly_exit(); //this creates the area the flies go through
                    };
                 };
                 translate([0,0,0])
                 rotate([180,0,0])
                 make_flyte_house();
             }
}

make_all();

// dim in mm
house_height = 10;
house_width = cap_radius * 4 / 3;
house_length = house_width / 2;
window_width = 2;
window_height = 3;
porch_width = house_width / 2.5;
porch_length = porch_width / 2;
triangle_height = 3;
post_radius=porch_width/20;


module make_flyte_house()
{
   union()
   {
      house();
      translate([0,(house_length+porch_length)/2,0])
      porch();
   }

}

module house()
{
   union()
   {
      difference()
      {
        union()
        {
           linear_extrude(height=house_height)
           square([house_width, house_length], center=true);
           back_porch();
        }
        windows();
        door();
        interior_space();
      }
      interior_posts();
   }
}

module back_porch()
{
   linear_extrude(height=house_height*0.1)
   circle(r=fly_exit);
}

module interior_space()
{
   translate([0,house_height*0.1,0])
   linear_extrude(height=house_height*0.8)
   square([house_width*0.9, house_length*0.8], center=true);
}

module interior_posts()
{
   // posts inside house to support roof

   // for (width_fraction = [-0.8, -0.5, 0.5, 0.8])
   for (width_fraction = [-0.65, 0.65])
   {
      for (length_fraction = [-0.2, 0.2])
      {
         translate([house_width * width_fraction / 2, house_length * length_fraction, house_height * 0.1])
         linear_extrude(height=house_height*0.9, scale=0.3)
         circle(r=post_radius*2.5, center=true);
      }
   }

}

module door()
{
   translate([-window_width*1.5/2,house_length/2,house_height*0.1])
   rotate([90,0,0])
   linear_extrude(height=house_length)
   square([window_width*2, window_height*2]);
}

module windows()
{
   for (h_fraction =[0.5, 0.7, 0.9])
   {
      for (v_fraction =[0.1, 0.5])
      {
         for (side = [-1, 1])
         {
            translate([(side*h_fraction*house_width*0.5)-window_width/2,house_length/2, v_fraction*house_height])
            rotate([90,0,0])
            linear_extrude(height=house_length)
            square([window_width, window_height]);
         }
      }
   }
}


module porch()
{
   union()
   {
      // basic shape
      difference()
      {
         linear_extrude(height=house_height)
         square([porch_width, porch_length], center=true);
         translate([0,0,house_height*0.1])
         linear_extrude(height=(house_height*0.8))
         square([porch_width*1.1, porch_length*1.1], center=true);
      }
      // front posts
      for (fraction =[0.05:0.3:0.95])
      {
         // translate([porch_width*fraction,porch_length,0])
         translate([(porch_width*fraction)-(porch_width/2),(porch_length*0.4),0])
         linear_extrude(height=house_height)
         circle(r=post_radius, center=true);
      }
      // back posts
      for (fraction =[0.05,0.95])
      {
         // translate([porch_width*fraction,porch_length,0])
         translate([(porch_width*fraction)-(porch_width/2),(porch_length*-0.5),0])
         linear_extrude(height=house_height)
         circle(r=post_radius, center=true);
      }
      // triangle on top
      translate([0,porch_length/2,0])
      rotate([90,0,0])
      linear_extrude(height=porch_length)
      polygon(points=[[(-porch_width/2),house_height],[(porch_width/2),house_height],[0,(house_height+triangle_height)]]);
      
   }
}

//this makes the cap with the threads 
module make_cap()
{
    cap_top_height = 1;
    union(){
        linear_extrude(height = cap_top_height)
        circle(cap_radius);
        translate([0,0,cap_top_height])
        make_threads();
        }; 
}


module make_threads()
{
   // translate([0,0,thread_length*1.2])
   // %circle(54/2);

   difference(){
      linear_extrude(height=thread_length)
      circle(cap_radius);
      metric_thread (diameter=thread_diam, pitch=thread_pitch, length=thread_length, n_starts=1, internal=true, thread_size=thread_pitch, leadin=0);
   }
   
}
 
module fly_exit()
{    
            linear_extrude(height = fly_exit_height, scale = fly_hole_scale)
                circle(fly_exit-1);
            
}

// make a sector of a circle
// from: https://openhome.cc/eGossip/OpenSCAD/SectorArc.html 
// radius = 20;
// angles = [45, 135];
// fn = 24;

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360])
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

// rotate specified angle a around point pt
module rotate_about_pt(a, pt) {
    translate(pt)
        rotate(a)
            translate(-pt)
                children();
}
