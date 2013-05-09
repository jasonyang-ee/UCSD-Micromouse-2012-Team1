#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"

class Sensor{
public:
  void runAllSensor();
/*=======================================================  individual sensor  =======================================================*/
  volatile int voltage;
  int runSensor(int);
/*=======================================================  conversion  =======================================================*/
  double convertDistance(int, int);
/*=======================================================  scenario  =======================================================*/
  void setScenario();
/*=======================================================  error  =======================================================*/
  void errorRight();
  void errorLeft();
  void errorDiagonal();
  void errorSide();
  void errorFront();
  void errorCountLeft();
/*=======================================================  PID value  =======================================================*/
  void angularVelocity();
};

#endif
