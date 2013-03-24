#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"

class Sensor{
public:
  void runAllSensor();
private:
  double SL, DL, FL, FR, DR, SR;
  double voltageTemp;
private:
  double runSensor(int);
};

#endif
