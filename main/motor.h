#ifndef MOTOR_H
#define MOTOR_H

#include "global.h"

class Motor{
public:
  void fixOrientation();
  void fixDeviation();
public:
  void stop();
  void goStraight(int);
  void turnLeft(int);
  void turnRight(int);
  void turnBack();
  void goLeft(int);
  void goRight(int);
private:
  void motorLeft(int);
  void motorRight(int);
};


#endif
