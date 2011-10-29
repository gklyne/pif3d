module mycube()
{
  cube(size = [30,20,10]);
}

mycube();

translate([-30,-20,-10])
  mycube();
