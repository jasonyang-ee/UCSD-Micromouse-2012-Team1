#ifndef MAZE_H
#define MAZE_H

#include "global.h"

class Maze{
public:
  void decide();
  
  void mapping();
  void adjacentWall(Cell*);
  
  void floodFill();
  
  void initialize();
};


#endif
