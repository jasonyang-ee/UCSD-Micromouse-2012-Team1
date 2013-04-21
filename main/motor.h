#ifndef MOTOR_H
#define MOTOR_H

#include "global.h"

class Motor{
public:
  void goStraightPID(int);
  void applyMotorMapping(int);
  void applyMotorRacing(int);
  
public:
  void stop();
  void goStraight(int);
  void goBack(int);
  void turnLeft(int);
  void turnRight(int);
  void turnBack();
  void goLeft(int);
  void goRight(int);
  
public:
  void motorLeft(int);
  void motorRight(int);
  
  double turnKP;
  double turnKI;
  double turnKD;

#define straightKP 1
#define straightKI 1
#define straightKD 1

#define driveTurnKP 1
#define driveTurnKI 1
#define driveTurnKD 1

};


#endif
