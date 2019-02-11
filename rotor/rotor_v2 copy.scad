
// rotate_extrude(convexity = 10)

 
// cube (30);

// fa is the minimum angle for a fragment
// fs is the minimum size of a fragment
// fn is the # of fragments to use
// circle (30, $fa=12);
// sphere (30, $fa=4);
// cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);

//
// Difference
// Subtract the 2nd (and subsequent) shapes from the 1st.
//
// difference() {
// translate([0,0,14]){circle(30);}
// cylinder(30, 10, 1, true);
// }

// Squares
// square(size = [x, y], center = true/false);
// square(size =  x    , center = true/false);
// square(30);


// make an ellipse by scaling or resizing a circle
// equivalent scripts for this example
// resize([30,10])circle(d=20);
// scale([1.5,.5])circle(d=20);

// rectangle by scaling a square
// scale([1.5,.5])square(20); // 15x5 rectangle (x,y)

// translate([2, 0, 0])
// circle(r = 1, $fn = 100);

// 3D text
// linear_extrude(height=10)
// text("Stenglein Lab", font = "Helvetica");

// rotate_extrude

// this is weird...
// rotate_extrude(height=10)
// translate([0,20,0])
// text("Stenglein Lab", font = "Helvetica");

// 
// rotate_extrude(height=10)

//
// $fn=40;

// I don't understand minkowski sets...
// minkowski() 
// {
// square([15,4]);
// translate([15,2])
// circle(d=4);
// }


$fn=180;
// I don't understand minkowski sets...

rotate_extrude()
{
   difference()
   {
      rotor_points=[ [0,23], [12,23], [12,17], [18,17], [30,5], [43,17], [45,15], [32,2], [28,2], [16,14], [0,14], [0,23] ];  
      central_hole_points=[[0,23], [1.7,23], [1.7,17], [0,17]];
      union()
      {
         polygon(rotor_points);
         translate([12,17])
         circle(r=6);
         translate([30,2])
         circle(r=2);
         translate([43,15])
         circle(r=2);
      }
      polygon(central_hole_points);
      polygon([[0,0], [0,14], [16,14],[28,2], [28,0],[0,0]]);
   }
}

x= 40; y = 40; z = 40; // point coordinates of end of cylinder

length = norm([x,y,z]);  // radial distance
b = acos(z/length); // inclination angle
c = atan2(y,x);     // azimuthal angle

// pi_4=PI/4;
// echo ("pi_4", pi_4);

// degrees not radians 
// rotate([0, b, (c+(i*pi_4))])

// make 8 cylinders
for(i = [0 : 7 ])
translate([0,0,-5.65])  // 11.3 mm diameter tube hole
rotate([0, b, (c+(i*45))])
    %cylinder(h=length, r=5.45);

// translate([0,0,-5.45])
// rotate([0, b, c])
    // %cylinder(h=length, r=5.45);

// cube([x,y,z]); // corner of cube should coincide with end of cylinder


/*
color("blue")
translate([21,7.8,0])
rotate([90,90,0])
cylinder(h=4, r1=5.45, r2=5.45, center=true);
*/



// rotating
// For the case of:

// rotate([a, b, c]) { ... };
// "a" is a rotation about the X axis, from the +Y axis, toward the +Z axis.
// "b" is a rotation about the Y axis, from the +Z axis, toward the +X axis.
// "c" is a rotation about the Z axis, from the +X axis, toward the +Y axis.

// These are all cases of the Right Hand Rule. Point your right thumb along the positive axis, your fingers show the direction of rotation.


