/*
 This is the pizza-table like platform that gets inserted into flyte-house topped bottles.

 It is designed to keep the flies away from the food.

 Originally designed by Lexi Keene, 2021
 Updated: Mark Stenglein, 2024
 */

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


$fn = 50;

// dimensions in mm

// bottle_diameter = 50;
bottle_diameter = 50.25;
thickness = 3.5;
post_diameter = 5;
post_height = 25;

holddown_thickness=2;
holddown_pin_radius=1.5;

make_tabletop_only = 1;

make_both = 0;

// make the tabletop
module table_top() {
  difference(){
    linear_extrude(thickness) 
    circle(r=bottle_diameter/2);
  
    linear_extrude(thickness * 1.1) circle(r=bottle_diameter/3);

    // make divots for inserting a hold-down for screen
    for (z_rot = [0: 120: 240], dist = (bottle_diameter/2) * 0.9 )
        rotate([0, 0, z_rot])
        // translate([dist, 0, thickness])
        translate([dist, 0, 0])
        linear_extrude(thickness * 0.5)
	// make holes a little overized so pins snap in
        circle(r=holddown_pin_radius*1.1);
  }
}


module hold_down() {
  union() {
    difference(){
      linear_extrude(holddown_thickness) 
      circle(r=bottle_diameter/2);
    
      linear_extrude(holddown_thickness * 1.1)
      circle(r=bottle_diameter/3);
    }
    // make divots for inserting a hold-down for screen
    for (z_rot = [0: 120: 240], dist = (bottle_diameter/2) * 0.9 )
      rotate([0, 0, z_rot])
      translate([dist, 0, holddown_thickness])
      linear_extrude(thickness * 0.5)
      // make pins a little undersized so they fit
      circle(r=holddown_pin_radius * 0.8);
  }
}

// make perforations in tabletop, 
// hopefully big enough for odor to get through but too small for flies
// perforations very slow to render so do don't do this
module table_top_with_perforations() {
  difference(){
    linear_extrude(thickness) 
    circle(r=bottle_diameter/2);
  
    for (z_rot = [0: 15: 345], dist = [bottle_diameter / 10: bottle_diameter / 20: bottle_diameter / 2.2] )
      rotate([0, 0, z_rot])
      translate([dist, 0, 0])
      linear_extrude(thickness * 1.1)
      circle(r=0.15);
  }
}

// this makes one post
module post(){
    linear_extrude(post_height)
    circle(d=post_diameter);
}


module table_legs()
{
  // make the three table legs
  for (z_rot = [0: 120: 240], dist = bottle_diameter/2 - post_diameter/2 - 1)
     rotate([0,0,z_rot])
     translate([dist, 0, thickness * 0.95])
     post();
}


// make tabletop or make hold-down or both
if (make_tabletop_only) {
  table_top();
  table_legs();
} else if (make_both) {
  table_top();
  table_legs();
  // move the hold-down over a bit
  translate([bottle_diameter * 1.1, 0, 0])
  hold_down();
}
else {
  hold_down();
}



