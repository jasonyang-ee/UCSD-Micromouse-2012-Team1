#ifndef CELL_H
#define CELL_H

#include "global.h"

class Cell{
public:
  bool visit;
  bool wall[4];
  bool goal;
  int x;
  int y;
  int floodValue;
  bool existance;
  bool dead;

  Cell *north;
  Cell *south;
  Cell *east;
  Cell *west;
};

#endif
