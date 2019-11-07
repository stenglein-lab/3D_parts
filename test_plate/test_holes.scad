
// this variable controls the resolution of the model (the number of fragments)
// decrease for coarser
$fn=50;

difference() {
 cube(size = [100,27,3]);
    union() {
     for(i = [1:10]) {
            translate([(i * i + i)/2 + 3 * i , 8,-1])
                // polyhole(h = 5, d = i);
                linear_extrude(h=5)
                circle(d = i);
                
            assign(d = i + 0.5)
                translate([(d * d + d)/2 + 3 * d, 19,-1])
                    // polyhole(h = 5, d = d);
                    linear_extrude(h=5)
                    circle(d = d);
     }
    }
}
