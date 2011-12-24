module skirting(h, t, l)
{
    cylr = 1.2*t;
    cylh = sqrt(2*cylr*t - t*t);
    translate([-l/2,-t,0])
        intersection()
        {
            union ()
            {
                cube(size=[l,t,h-cylh]);
                translate([0,cylr,h-cylh]) rotate([0,90,0]) cylinder(r=cylr, h=l);
            }
            cube(size=[l,t,h]);
        }
}


//union()
//{
//   translate([-200,-15,0]) skirting(100, 15, 200);
//   rotate([0,0,90]) translate([   0,-15,0]) skirting(100, 15, 200);
//}

delta = 0.01;

union()
{
    translate([-100+delta,0,0])
    {
        difference()
        {
            skirting(100, 15, 200);
            translate([-100,0,0]) rotate([0,0,90]) skirting(100, 15, 200);
        }
    }
    rotate([0,0,90]) translate([100-delta,0,0])
    {
            difference()
            {
                skirting(100, 15, 200);
                translate([100,0,0]) rotate([0,0,-90]) skirting(100, 15, 200);
            }
    }
    intersection()
    {
        translate([-100+15,0,0]) skirting(100, 15, 200);
        rotate([0,0,90]) translate([-100,0,0]) skirting(100, 15, 200);
    }
}

