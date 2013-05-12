#ifndef RACING_H
#define RACING_H

#include "global.h"

class Racing{
public: 
  void easyRun(int);
  void homeRun(int);
  void speedRun(int);

  void next(Cell*);
  void neighbor(volatile Cell*);
  void initialize();
  
  int step;
  int numbStraight;
  
  bool nextStraight;
  
  //There are three different types of  straight-turns: S turn, U turn, and Angle(L) Turns
  bool nextRightL;
  bool nextLeftL;  
  bool nextRightS;
  bool nextLeftS;
  bool nextRightU;
  bool nextLeftU;
  
  Cell *frontCell;
  Cell *rightCell;
  Cell *leftCell;
  
  //Three possible turns: S Turn, U turn, Angle Turn

 

};

#endif

