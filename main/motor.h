#ifndef MOTOR_H
#define MOTOR_H

#include "global.h"

class Motor{
public:
  void stop();
  void driveStright();
  void turnLeft();
  void turnRight();
  void turnBack();
  void driveLeftTurn();
  void driveRightTurn();
private:
  void motorLeft();
  void motorRight();
};


#endif
