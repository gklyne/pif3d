// Bracket for storing boat rear deck cover support

// ------------------------
// Shape crafting primitves
// ------------------------

// External chamfer along X-axis from given point which lies
// on the edge to be chamfered off, marked with "+":
//
//   +-.---
//   |/
//   .
//   |
//
// Point p is at one end, and the other end is at p+[l,0,0],
// (so the sign of l controls the direction to the other end).
//
// w is the size of the chamfer (distance from "+" to "." above).
//
// q=0 -> chamfer to +y,+z
// q=1 -> chamfer to -y,+z
// q=2 -> chamfer to -y,-z
// q=3 -> chamfer to +y,-z
// (Non-integral values of Q can tweak the chamfer angle,
// but the value of w is not preserved.)
//
// The chamfer is defined as a shape that is to be subtracted from
// the original to which the chamfer is applied.
//
module chamferX(p, l, w, q, d)
{
  xl = abs(l);
  xo = min(l,0);
  translate(p)
    rotate([45+q*90,0,0])
      translate([xo-d,0,-w])
        cube(size=[xl+2*d,w/sqrt(2),w*2]);
}

// External chamfer aligned with Y-axis
//
// q=0 -> chamfer to +x,+z
// q=1 -> chamfer to -x,+z
// q=2 -> chamfer to -x,-z
// q=3 -> chamfer to +x,-z
//
module chamferY(p, l, w, q, d)
{
  yl = abs(l);
  yo = min(l,0);
  translate(p)
    rotate([0,-45-q*90,0])
      translate([0,yo-d,-w])
        cube(size=[w/sqrt(2),yl+2*d,w*2]);
}

// External chamfer aligned with Z-axis
//
// q=0 -> chamfer to +x,+y
// q=1 -> chamfer to -x,+y
// q=2 -> chamfer to -y,-y
// q=3 -> chamfer to +y,-y
//
module chamferZ(p, l, w, q, d)
{
  zl = abs(l);
  zo = min(l,0);
  translate(p)
    rotate([0,0,45+q*90])
      translate([0,-w,zo-d])
        cube(size=[w/sqrt(2),w*2,zl+2*d]);
}


// Y-axis internal chamfer located on/ending at a given edge;
// marked "+" or "*" here:
//
//   .-*---
//   |/
//   +
//   |
//
// Point p is at one end, and the other end is at p+[0,l,0],
// (so the sign of l controls the direction to the other end).
//
// w is the size of the chamfer (distance from "+" to "." above).
//
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

// -----------
// The bracket
// -----------

// lo = length overall
// wo = width overall
// ho = height overall
// li = length of internal space
// hi = height of internal space
// he = height of end lip
// le = end lip length
// hd = screw hole diameter
// d  = delta for CSG
//
module bracket(lo, wo, ho, li, hi, le, he, hd, d)
{
  co = ho - hi - he -1 ;
  difference()
  {
    cube(size=[lo, wo, ho]);
      translate([lo-li-le,-d,ho-hi]) cube([lo,wo+2*d,hi+d]);       // gap
      translate([lo-li-le-hi,-d,ho-hi-he]) cube([li,wo+2*d,hi+d]); // int
      chamferYint([lo-le-hi,0,ho-hi-he], wo, hi, 0, d);
      chamferYint([lo-li-le-hi,0,ho-he], wo, hi, 3, d);
      chamferX([0,0,0], lo, co, 0, d);
      chamferX([0,wo,0], lo, co, 1, d);
      chamferY([0,0,0], lo, co+hi*0.5, 0, d);
      chamferY([lo,0,0], wo, co+hi, 1, d);
      chamferYint([lo-hi,0,co], wo, co+hi, 3.3, d);
      translate([wo/2,wo/2,-d]) cylinder(r=hd/2, h=ho+d*2, $fa=30, $fs=0.25);
      translate([wo/2,wo/2,-d]) cylinder(r1=hd+d, r2=0, h=hd+d, $fs=0.25);
  }
}

// -----------------
// Top level objects
// -----------------

//translate([10,20,0]) sphere(r=2, $fn=12);

//chamferZ([10,20,0], -30, 5, 1, 0.5);

//chamferYint([10,20,0], -30, 5, 3, 0.5);

lenoverall  = 72;
widoverall  = 25;
hgtoverall  = 15;
leninternal = 40;
hgtinternal = 7;
lenend      = 5;
hgtend      = 3;
holedia     = 4;

translate([-lenoverall/2, 5, 0])
  bracket(lenoverall, widoverall, hgtoverall, 
          leninternal, hgtinternal, 
          lenend, hgtend, 
          holedia, 0.1);

translate([-lenoverall/2, -widoverall-5, 0])
  bracket(lenoverall, widoverall, hgtoverall, 
          leninternal, hgtinternal, 
          lenend, hgtend, 
          holedia, 0.1);

