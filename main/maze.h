#ifndef MAZE_H
#define MAZE_H

#include "global.h"

class Maze{
public:
  void initialize();
  void setWall();
  
private:
  int currentX;
  int currentY;
  
public:
  void printAll();
};


#endif
