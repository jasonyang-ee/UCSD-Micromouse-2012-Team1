#ifndef STATUS_H
#define STATUS_H

class STATUS{
public:
  STATUS();
  CELL position;
  int frontWallDist;
  int leftWallDist;
  int rightWallDist;
  int orientation;
  int centerDeviation;  //the centerness from the side wall
  int direction;        //the current facing diraction
}


#endif
