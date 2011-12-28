delta = 0.5;

module RoundedEnd(l,r,h)
{
    union()
    {
      translate([0,0,0]) cylinder(r=r,h=h);
      translate([0,-r,0]) cube(size=[l+r,2*r,h]);
    }
}

module RoundedEnds(l,r,h)
{
    union()
    {
      translate([0,0,0]) cylinder(r=r,h=h);
      translate([l,0,0]) cylinder(r=r,h=h);
      translate([0,-r,0]) cube(size=[l,2*r,h]);
    }
}

module TaperedRoundedEnds(l,r,h)
{
    intersection()
    {
        RoundedEnds(l,r,h);
        rotate(asin(r/l), [0,0,-1]) RoundedEnd(l,r,h);
    }
}


module ElectronicsBracket(length1, length2, holedia, offset, thickness, 
                          mountholes, mountholedia)
{
    difference()
    {
        union()
        {
            // Arm segment that hangs on top rail
            rotate(asin(offset/length1), [0,0,-1])
            {
                translate([-length1,0,0])
                {
                    difference()
                    {
                        TaperedRoundedEnds(length1, holedia, thickness);
                        translate([0,0,-delta]) cylinder(r=holedia/2,h=thickness+2*delta);
                        // Cut-out for in situ clip-on attachment
                        rotate([0,0,-18])
                            translate([0,-(holedia-delta)/2,-delta])
                                cube([length1, holedia-delta, thickness+2*delta]);                        
                    }
                }
            }
            // Arm segment for attaching mounting plate
            translate([0,-holedia/2,0])
            {
                rotate(asin(holedia/2/length2),[0,0,1])
                {
                    TaperedRoundedEnds(length2, holedia/2, thickness);
                }
            }
        }
        // Mounting holes
        for (x = mountholes)
        {
            translate([x,delta,thickness/2]) 
                rotate([90,0,0]) 
                    cylinder(r=mountholedia/2,h=holedia*2);
        }
    }
}

for (y = [-20,20])
{
    translate([0,y,0]) ElectronicsBracket(40, 78, 8, 9, 10, [5,15,25,35,45,55,65,75], 3);
}

