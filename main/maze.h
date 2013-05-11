#ifndef MAZE_H
#define MAZE_H

#include "global.h"

class Maze{
public:
  int decide();
  void goHome();
  
  void mapping();
  void adjacentWall(Cell*);
  
  void flood();
  void expand(int, int, int);
  void northFlood(int, int, int);
  void eastFlood(int, int, int);
  void southFlood(int, int, int);
  void westFlood(int, int, int);
  
  bool returnBranch;
  int branchValue;
  
  void initialize();
};


#endif
