
// miniround([20,20,20],1);
miniround([20,20,20],1);

module miniround(size, radius)
{
$fn=50;
x = size[0]-radius/2;
y = size[1]-radius/2;
// echo (size=size, x=x, y=x, radius=radius)

minkowski()
{
    cube(size=[x,y,size[2]]);
    cylinder(r=radius);
    // Using a sphere is possible, but will kill performance
    //sphere(r=radius);
}
}
