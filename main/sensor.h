#ifndef SENSOR_H
#define SENSOR_H

class SENSOR{
private:
  int voltageTemp;
  int idleVoltage;
  int activeVoltage;
  int distance;
  int currentPos;
  
public:
  SENSOR();
  int runAllSensor();
  int runSensor(int);
  void convertDistance();
  void setWall(int, int);
}

#endif
