#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"

class Sensor{
public:
  void runAllSensor();
private:
  volatile int voltageTemp;
  volatile int idleVoltage;
  volatile int activeVoltage;
  volatile int resultVoltage;
private:
  int runSensor(int);
  int convertDistance(int);
  void setOrientation();
  void setDeviation();
  
public:
  void printAll();
};

#endif
