module mycube()
{
  translate([-20,0,0])
    cube(size = [40,20,10]);
}

union()
{
  mycube();
  rotate([0,-90,0])
    mycube();
}
