/*
-- Direction code --
    N          0
  W   E  ==  3   1
    S          2
*/

void CELL::CELL()
{
  visit = false;
  wall[0] = false;
  wall[1] = false;
  wall[2] = false;
  wall[3] = false;
  goal = false;
}
