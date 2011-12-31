use <SpoolHolder.scad>

// Test possible Skeinforge problem
module TestThreeSpokedWheel(rd, rt, hd, ht, ad, at)
{
    d  = 1;
    t  = 2.3;    // thickness of hub tube
    bh = 0.5;  // height of retaining bump
    bt = 4;    // thickness of retaining bump
    b2 = bh*2;
    
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

