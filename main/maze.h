#ifndef MAZE_H
#define MAZE_H

#include "global.h"

class Maze{
public:
  int decide(int);
  void mapping();
  void floodFill();
  
  int nextdead;
  int directx;
  int directy;
  
  void initialize();
};


#endif
