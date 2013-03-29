#ifndef CELL_H
#define CELL_H

#include "global.h"

class Cell{
//elements
public:
  bool visit;
  bool wall[4];
  bool goal;
  int x;
  int y;
  int floodValue;
  bool existance;
//link list siblings
public:
  Cell *north;
  Cell *south;
  Cell *east;
  Cell *west;
};

#endif
