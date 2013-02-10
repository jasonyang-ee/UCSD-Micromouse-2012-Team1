#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  Cell currentCell;
  
  int frontDist;
  int sideLeftDist;
  int sideRightDist;
  int diagonalLeftDist;
  int diagonalRightDist;
  
  int orientation;      //0 is facing streaght, clockwise angle is positive
  int deviation;        //0 is in the center, close to right wall is positive
  int compass;
  
  int leftWheelCount;
  int rightWheelCount;
  
public:
  void printAll();
};


#endif
