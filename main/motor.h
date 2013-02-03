#ifndef MOTOR_H
#define MOTOR_H

#include "global.h"

class Motor{
private:
  int speedRight;
  int speedLeft;
  int speedCorrect;
public:
  int fixOrientation();
public:
  void stop();
  void driveStright();
  void turnLeft();
  void turnRight();
  void turnBack();
  void driveLeftTurn();
  void driveRightTurn();
private:
  void motorLeft(int);
  void motorRight(int);
};


#endif
