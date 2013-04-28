#ifndef MAZE_H
#define MAZE_H

#include "global.h"

class Maze{
public:
//  void mapping();
  void floodFill();
  int directy; //Orientation in y. directy = 1, 0, -1 (North, Horizontal, South)
  int directx; //Orientaiton in x. directx = 1, 0, -1 (East, Vertical, West)
  
public:
  void initialize();
  void printAll();
};


#endif
