#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"

/*
-- Direction code --
    N          0
  W   E  ==  3   1
    S          2
*/

class Sensor{
public:
  void runAllSensor();
private:
  int voltageTemp;
  int idleVoltage;
  int activeVoltage;
  int resultVoltage;
private:
  int runSensor(int);
  int convertDistance(int);
  void setOrientation();
  void setDeviation();
  
public:
  void printAll();
};

#endif
