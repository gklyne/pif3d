module mycube()
{
  translate([-2,0,0])
    cube( size=[4,2,1] );
}

union()
{
  mycube();
  rotate([0,-90,0])
    mycube();
}

