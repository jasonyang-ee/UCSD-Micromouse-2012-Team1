#ifndef STATUS_H
#define STATUS_H

#include "global.h"

class Status{
public:
  //sensor status
  int frontDist;
  int sideLeftDist;
  int sideRightDist;
  int diagonalLeftDist;
  int diagonalRightDist;
  
  //raw sensor status
  int frontVolt;
  int sideLeftVolt;
  int sideRightVolt;
  int diagonalLeftVolt;
  int diagonalRightVolt;
  
  //position status
  Cell currentCell;
  int orientation;      //0 is facing streaght, clockwise angle is positive
  int deviation;        //0 is in the center, close to right wall is positive
  int compass;
  
  //encoder status
  int leftWheelCount;
  int rightWheelCount;
  
  //motor status
  int speedLeft;
  int speedRight;
  
public:
  void initialize();
  void printAll();
};


#endif
