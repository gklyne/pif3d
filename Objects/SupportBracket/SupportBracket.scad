// Bracket for storing boat rear deck cover support

// ------------------------
// Shape crafting primitves
// ------------------------

use <../ShapeLibrary/Chamfer.scad>

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

