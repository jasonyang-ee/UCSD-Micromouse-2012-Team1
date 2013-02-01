#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  Cell position;
  int frontWallDist;
  int leftWallDist;
  int rightWallDist;
  int orientation;      //0 is facing streaght
  int centerDeviation;  //0 is in the center of the cell (sidewise)
  int direction;        //the current facing diraction
};


#endif
