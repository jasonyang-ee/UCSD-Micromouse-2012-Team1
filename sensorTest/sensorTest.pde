#include "global.h"

void setup()
{
  pinMode(sensorFrontLeft,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(sensorFrontRight,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(sensorDiagonalLeft,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(sensorDiagonalRight,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(sensorSideLeft,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(sensorSideRight,INPUT_ANALOG);  //int sensorSideRight
  pinMode(ledOne, OUTPUT);
  pinMode(ledTwo, OUTPUT);
  pinMode(ledThree, OUTPUT);
  
  digitalWrite(ledOne, HIGH);
  digitalWrite(ledTwo, HIGH);
  digitalWrite(ledThree, HIGH);
}

void loop()
{

  sensor.runAllSensor();
}
