#ifndef MAZE_H
#define MAZE_H

#include "global.h"

class Maze{
public:
  void mapping();
  
private:
  void setWall();
  
public:
  void initialize();
  void printAll();
};


#endif
