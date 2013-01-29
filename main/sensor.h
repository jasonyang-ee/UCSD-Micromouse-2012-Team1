#ifndef SENSOR_H
#define SENSOR_H

class SENSOR{
private:
  int voltageTemp;
  int idleVoltage;
  int activeVoltage;
  int distance;
  int currentPosition;
  
public:
  SENSOR();
  int runAllSensor();
  int runSensor(int);
  int convertDistance();
  void setWall();
}

#endif
