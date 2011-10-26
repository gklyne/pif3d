module box(l, w, h, t)
{
  t2 = t * 2;
  difference()
  {
    cube( size=[l,w,h] );
    translate([t,t,t])
      cube( size=[l-t2, w-t2, h-t]) ;
  }
}

module lid(l, w, t)
{
  t2 = t * 2;
  t4 = t * 4;
  difference()
  {
    union()
    {
      cube( size=[l, w, t] );
      translate( [t, t, t*0.5] )
        cube( size=[l-t2, w-t2, t*1.5] );
    }
    translate( [t2, t2, t] )
      cube( size=[l-t4, w-t4, t2] );
  }
}

module support(dl, dw, h)
{
}

// Try it out
l = 30;		// Length
w = 20;		// Width
h = 10;		// Height
t = 1;		// Wall thickness
s = 5;		// Spacing

translate([s,0,0])
  box(l, w, h, t);

translate([-s-l, 0, 0])
  lid(l, w, t);
