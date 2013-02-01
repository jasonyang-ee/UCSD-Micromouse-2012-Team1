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
  void setWall(Cell);
  void getOrientation();
  
private:
  int voltageTemp;
  int idleVoltage;
  int activeVoltage;
  int currentPos;
  int frontWallDist;
  int leftWallDist;
  int rightWallDist;
  int diagonalLeftDist;
  int diagonalRightDist;
private:
  int runSensor(int);
  int convertDistance(int);
};

#endif
