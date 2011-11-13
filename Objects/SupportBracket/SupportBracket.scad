// Bracket for storing boat rear deck cover support

// q=0 -> chamfer to +y,+z
// q=1 -> chamfer to -y,+z
// q=2 -> chamfer to -y,-z
// q=3 -> chamfer to +y,-z
module chamferX(p, l, w, q, d)
{
  xl = abs(l);
  xo = min(l,0);
  translate(p)
    rotate([45+q*90,0,0])
      translate([xo-d,0,-w])
        cube(size=[xl+2*d,w/sqrt(2),w*2]);
}

// q=0 -> chamfer to +x,+z
// q=1 -> chamfer to -x,+z
// q=2 -> chamfer to -x,-z
// q=3 -> chamfer to +x,-z
module chamferY(p, l, w, q, d)
{
  yl = abs(l);
  yo = min(l,0);
  translate(p)
    rotate([0,-45-q*90,0])
      translate([0,yo-d,-w])
        cube(size=[w/sqrt(2),yl+2*d,w*2]);
}

// q=0 -> chamfer to +x,+y
// q=1 -> chamfer to -x,+y
// q=2 -> chamfer to -y,-y
// q=3 -> chamfer to +y,-y
module chamferZ(p, l, w, q, d)
{
  zl = abs(l);
  zo = min(l,0);
  translate(p)
    rotate([0,0,45+q*90])
      translate([0,-w,zo-d])
        cube(size=[w/sqrt(2),w*2,zl+2*d]);
}


// Y-axis chamfer located on/ending at inner corner
// q=0 -> chamfer to +z
// q=1 -> chamfer to -x
// q=2 -> chamfer to -z
// q=3 -> chamfer to +x
module chamferYint(p, l, w, q, d)
{
  yl = abs(l);
  yo = min(l,0);
  translate(p)
    rotate([0,-45-q*90,0])
      translate([0,yo-d,0])
        cube(size=[w*sqrt(2),yl+2*d,w*sqrt(2)]);
}



module bracket(lo, wo, ho, li, hi, le, hd, d)
{
  co = ho - 2*hi -1 ;
  difference()
  {
    cube(size=[lo, wo, ho]);
      translate([lo-li-le,-d,ho-hi]) cube([lo,wo+2*d,hi+d]);
      translate([lo-li-le-hi,-d,ho-hi*2]) cube([li,wo+2*d,hi+d]);
      chamferYint([lo-le-hi,0,ho-hi*2], wo, hi, 0, d);
      chamferYint([lo-li-le-hi,0,ho-hi], wo, hi, 3, d);
      chamferX([0,0,0], lo, co, 0, d);
      chamferX([0,wo,0], lo, co, 1, d);
      chamferY([0,0,0], lo, co+hi*0.5, 0, d);
      chamferY([lo,0,0], wo, co+hi, 1, d);
      translate([wo/2,wo/2,-d]) cylinder(r=hd/2, h=ho+d*2, $fa=30, $fs=0.25);
      translate([wo/2,wo/2,-d]) cylinder(r1=hd+d, r2=0, h=hd+d, $fs=0.25);
  }
}


// Top level objects


//translate([10,20,0]) sphere(r=2, $fn=12);

//chamferZ([10,20,0], -30, 5, 1, 0.5);

//chamferYint([10,20,0], -30, 5, 3, 0.5);

lenoverall  = 70;
widoverall  = 25;
hgtoverall  = 15;
leninternal = 40;
hgtinternal = 5;
lenextra    = 5;
holedia     = 4;
bracket(lenoverall, widoverall, hgtoverall, leninternal, hgtinternal, lenextra, holedia, 0.1);

