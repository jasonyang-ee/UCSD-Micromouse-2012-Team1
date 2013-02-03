#ifndef SENSOR_H
#define SENSOR_H

#include "global.h"
#include "cell.h"
#include "status.h"

/*
-- Direction code --
    N          0
  W   E  ==  3   1
    S          2
*/

class Sensor{
public:
  void runAllSensor();
  void setWall();
  
private:
  int voltageTemp;
  int idleVoltage;
  int activeVoltage;
private:
  int runSensor(int);
  int convertDistance(int);
  void setOrientation();
  void setDeviation();
};

#endif
