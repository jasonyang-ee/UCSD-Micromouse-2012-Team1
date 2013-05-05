#ifndef CELL_H
#define CELL_H

#include "global.h"

class Cell{
public:
  bool visit;
  bool wall[4];
  bool dead;
  int floodValue;
  
  int x;
  int y;
  bool goal;
  bool existance;

  Cell *cellNorth;
  Cell *cellSouth;
  Cell *cellEast;
  Cell *cellWest;
};

#endif
