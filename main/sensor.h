#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"

class Sensor{
public:
  void runAllSensor();
  float rightError();
private:
  volatile int voltage;
private:
  int runSensor(int);
  void convertDistance(int, int);
  void setOrientation();
  void setDeviation();
  void setBalance();
};

#endif
