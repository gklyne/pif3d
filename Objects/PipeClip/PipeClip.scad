// od = overall diameter (for screw head)
// oh = overall height (screw + head +recesss)
// sd = screw diameter
// sh = screw height (to top of countersink)
module countersink(od, oh, sd, sh, d)
{
    union()
    {
        intersection()
	    {
            translate([0,0,-sh-d]) cylinder(r=od/2, h=oh+2*d, $fn=12);
            translate([0,0,-od/2]) cylinder(r1=0, r2=oh+od/2, h=oh+od/2, $fn=12);
        }
    translate([0,0,-sh]) cylinder(r=sd/2, h=sh, $fn=12);
    }
}

// l   = length of clip
// w   = width (depth) of clip
// h   = height of clip
// pd  = pipe hole diameter
// pg  = pipe gap diameter
// shd = Screw head diameter
// ssd = screw shaft diameter
// d   = delta
module PipeClip(l, w, h, pd, pg, shd, ssd, d)
{
    difference()
    {
        translate([-l/2,0,0])
            cube(size=[l, w, h]);
        translate([0,-d,h]) 
            rotate([-90,0,0]) 
                cylinder(r=pg/2, h=w+2*d);
        translate([0,-d,h-pg/2]) 
            rotate([-90,0,0]) 
                cylinder(r=pd/2, h=w+2*d);
        translate([0,w/2,h-(pd+pg)/2]) 
            countersink(shd, h, ssd, h-(pd+pg)/2+d, d);
        translate([l/2,-d,0]) 
            rotate([0,-15,0]) 
                cube(size=[l,w+2*d,h+w]);
        translate([-l/2,-d,0]) 
            rotate([0,15,0]) 
                translate([-l,0,0]) 
                    cube(size=[l,w+2*d,h+w]);
    }
}

l = 15;
w = 8;
p = l+w;
xn   = 3;
yn   = 1;
xlim = (xn-1)/2;
ylim = (yn-1)/2;

for (xo = [-xlim:xlim])
{
    for (yo = [-ylim:ylim])
    {
        translate([xo*p,yo*p,0])
            PipeClip(l, w, 8, 5.75, 4.75, 6, 3, 1);
    }
}


//PipeClip(15, 8, 10, 7, 6, 6, 3, 1);

//translate([0,-20,0]) countersink(6, 12, 3, 6, 1);