
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
union()
{
union()
{
	square([10,12]);
   translate([0,5])
	square([15,4]);
	translate([15,7])
	circle(d=4);
}
translate([12,7])
rotate([0,0,-45])
translate([0,18])
union() 
{
translate([0,-18])
square([4,20]);
translate([2,0])
square([13,4]);
translate([2,2])
circle(d=4);
translate([15,2])
circle(d=4);
}
}
}

// rotating
// For the case of:

// rotate([a, b, c]) { ... };
// "a" is a rotation about the X axis, from the +Y axis, toward the +Z axis.
// "b" is a rotation about the Y axis, from the +Z axis, toward the +X axis.
// "c" is a rotation about the Z axis, from the +X axis, toward the +Y axis.

// These are all cases of the Right Hand Rule. Point your right thumb along the positive axis, your fingers show the direction of rotation.


