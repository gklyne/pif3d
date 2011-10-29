module mycube()
{
  translate([10,0,0])
    cube(size = [30,20,10]);
}

mycube();

rotate([0,-90,0])
  mycube();
