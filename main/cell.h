#ifndef CELL_H
#define CELL_H

#include "global.h"

class Cell{
public:
  bool visit;
  bool wall[4];
  bool goal;
  int floodValue;
};

#endif
