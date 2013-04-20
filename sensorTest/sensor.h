#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"

class Sensor{
public:
  void runAllSensor();
private:
  volatile int voltage;
private:
  int runSensor(int);
  void convertDistance(int, int);
  void setOrientation();
  void setDeviation();
};

#endif
