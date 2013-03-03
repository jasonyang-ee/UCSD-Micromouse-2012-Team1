#ifndef SENSOR_H
#define SENSOR_H

class Sensor{
public:
  void runAllSensor();
private:
  double darkV, activeV;
private:
  int runSensor(int);
};

#endif
