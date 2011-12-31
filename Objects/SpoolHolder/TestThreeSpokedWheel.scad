use <SpoolHolder.scad>

// Test possible Skeinforge problem
module TestThreeSpokedWheel(rd, rt, hd, ht, ad, at)
{
    d  = 1;
    t  = 2.4;    // thickness of hub tube
    
    difference()
    {
        union()
        {
            tube(hd, hd-2*t, ht);
            threespokes(rd, 4, rt);
        }
        translate([0,0,-d]) 
            cylinder(r=ad/2, h=at+2*d);    
    }
}

axledia = 8+0.25;

TestThreeSpokedWheel(38+6, 3, 38, 3, axledia, 3);

