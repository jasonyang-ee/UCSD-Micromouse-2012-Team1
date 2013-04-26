#ifndef MOTOR_H
#define MOTOR_H

#include "global.h"

class Motor{
public:
  void fixOrientation(int);
  void applyMotorMapping(int);
  void applyMotorRacing(int);
  
public:
  void stop();
  void goStraight(int);
  
  void goStraightOne (int);
  
  void goBack(int);
  void turnLeft(int);
  void turnRight(int);
  void turnBack();
  void goLeft(int);
  void goRight(int);
public:
  void motorLeft(int);
  void motorRight(int);
};


#endif
