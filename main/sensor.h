#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"

class Sensor{
public:
  volatile int voltage;

  void runAllSensor();
  
  int runSensor(int);
  int convertDistance(int, int);
  
  void setScenario();
  
  void setErrorDiagonal();
  void setErrorSide();
  void setErrorFront();
};

#endif
