// Fruit fly trap 
// This bottle cap fits on standard sized 70mm US canning jars

// This is based on a design from Shaun Cross, modified by Mark Stenglein

/* This file includes code from the thread library,
 * Copyright 2017 Dan Kirshner - dan_kirshner@yahoo.com,
 * which is licensed under the GNU GPL v3.0.
 * This library is available from::
 * http://dkprojects.net/openscad-threads/
*/

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

// size parameters
cap_radius = 76/2;      // a little wider than threads

fly_exit_height = 25;   // how long the fly exit is
fly_exit = 15;          // starting radius of the linear extrude
fly_exit_scale = 0.133; // the scaling value (ending exit size from linear extrude)
fly_hole_scale = 0.1;   // the size of the hole that gets removed from the fly exit

// threads on cap (mm)
// standard 70-450 CT US canning jar
thread_pitch  = 6.35; // 0.25 inches
thread_length = 10;   // at least as long as cap height
thread_diam   = 72;   // empirically tweaked from 70

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
                 translate([0,0,-weird_cap_height])
                 make_weird_top();
             }
}

make_all();
// make_cap();

// linear_extrude (height=5) square([70, 3], true);

module make_weird_top_channels()
{
        union(){
            difference(){
            linear_extrude(height=weird_cap_height)
            circle(cap_radius);

            for (angle =[0:18:360 ])
            {
               linear_extrude(height=weird_cap_height)
               rotate([0,0,angle])
               sector(cap_radius*1.05, [-5,5], 50);
            }

            linear_extrude(height=weird_cap_height)
            circle(fly_exit*1.2);

            };

            linear_extrude(height = 2)
            circle(cap_radius);
        }
}

module make_weird_top()
{
        union(){

            // posts
            for (angle =[0:18:342 ])
            {
               for (rad =[fly_exit*1.1:5:cap_radius/1.75 ])
               {
                  translate([(cos(angle)*rad), (sin(angle)*rad), 0])
                  linear_extrude(height=weird_cap_height, scale=1.25)
                  circle(1);
               }
            }

            // top surface 
            linear_extrude(height = 1.5)
            circle(cap_radius/1.75);
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
   difference(){
      linear_extrude(height=thread_length*0.999)
      circle(cap_radius);
      metric_thread (diameter=thread_diam, pitch=thread_pitch, length=thread_length, n_starts=1, internal=true, thread_size=thread_pitch/3, leadin=0);
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
