#ifndef SENSOR_H
#define SENSOR_H

#include "HEAD_h"
#include "cell.h"

class SENSOR{
private:
  int voltageTemp;
  int idleVoltage;
  int activeVoltage;
  int currentPos;
public:
  SENSOR();
  int runAllSensor();
  void setWall(int, int);
  void getOrientation();
private:
  int runSensor(int);
  int convertDistance();
}

#endif
