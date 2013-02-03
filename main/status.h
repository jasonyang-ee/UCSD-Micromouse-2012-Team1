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
  int orientation;      //0 is facing streaght
  int deviation;        //0 is in the center of the cell (sidewise)
  int compass;          //the current facing diraction
  
public:
  void printAll();
};


#endif
