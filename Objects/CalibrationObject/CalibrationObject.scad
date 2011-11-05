// Calibration piece for RepRap

difference()
{
  cube([100,100,2], center=false);
  translate([2,2,-1]) cube([96, 96, 4], center=false);
};

module step()
{
  cube([100,10,20]);
}

module steps()
{
  for ( i = [0:10] )
  {
    translate([-i*9,0,20-i]) cube([100,10,20], center=false);
  }
}

difference()
{
  step();
  steps();
}

