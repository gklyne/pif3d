module tube(od, id, l)
{
    d = 1;
    difference()
    {
        cylinder(r=od/2, h=l);
        translate([0,0,-d]) cylinder(r=id/2, h=l+2*d);
    }
}

module threespokes(od, et, t)
{
    d = 1;
    difference()
    {
        cylinder(r=od/2, h=t);
        for (a=[0,120,240])
            translate([od*cos(a),od*sin(a),-d])
                cylinder(r=0.5*(sqrt(3)*od-et), h=t+d*2);
    }
}


module SpoolHolder(rd, rt, hd, ht, ad, at)
{
    d  = 1;
    t  = 2;
    bh = 0.5;  // height of retaining bump
    bt = 4;    // thickness of retaining bump
    b2 = bh*2;
    // Outer rim
    difference()
    {
        union()
        {
            threespokes(rd, 4, rt);
            difference()
            {
                union()
                {
                    cylinder(r=hd/2, h=ht);
                    translate([0,0,ht-bt]) 
                        intersection()
                        {
                            cylinder(r1=hd/2, r2=hd/2+b2, h=bt);
                            cylinder(r1=hd/2+b2, r2=hd/2, h=bt);
                            threespokes(rd, 8, bt);
                        }
                }
                translate([0,0,-d]) 
                    cylinder(r=(hd/2)-t, h=ht+d);
            }
            cylinder(r=(ad/2)+t, h=at);
        }
        translate([0,0,-d]) 
            cylinder(r=ad/2, h=at+2*d);    
    }
}

module SpoolSpacer(ad,l)
{
    tube(ad+4, ad, l);
}


for (x = [-25,25])
{
    translate([x,0,0])
    {
        SpoolHolder(38+8, 3, 38, 10, 8, 5);
        translate([0,35,0]) SpoolSpacer(8, 10) ;
        translate([0,-35,0]) SpoolSpacer(8, 4) ;
    }
}

// threespokes(20, 3, 5);

