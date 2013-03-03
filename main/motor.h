#ifndef MOTOR_H
#define MOTOR_H

#include "global.h"

class Motor{
private:
  int speedRight;
  int speedLeft;
public:
  void fixOrientation();
  void fixDeviation();
public:
  void stop();
  void driveStraight(int);
  void turnLeft(int);
  void turnRight(int);
//  void turnBack();
  void driveLeft(int);
  void driveRight(int);
private:
  void motorLeft(int);
  void motorRight(int);
};


#endif
