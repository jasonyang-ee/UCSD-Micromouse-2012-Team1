#ifndef MAZE_H
#define MAZE_H

#include "global.h"

class Maze{
public:
  void initialize();
  void mapping();
  
private:
  void setWall();
  int currentX;
  int currentY;
  
public:
  void printAll();
};


#endif
