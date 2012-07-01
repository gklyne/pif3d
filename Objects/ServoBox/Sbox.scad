module top()
{
translate([-5.5, 0,0])
cube([56,23,4]);
cube([45.5,23,27]);
}

difference() 
{
top();
translate([1.5, 1.5,-4.5])
cube([42.5,20,30]);
translate([-7, -4,-1])
cube([60,15,30]);
}

