#ifndef CELL_H
#define CELL_H

#include "global.h"

class Cell{
public:
  void setCurrent();
public:
  bool visit;
  bool wall[4];
  bool goal;
  int x;
  int y;
  int floodValue;
public:
  Cell operator++(int);
};

#endif
