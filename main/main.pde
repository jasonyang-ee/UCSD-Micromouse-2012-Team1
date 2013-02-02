#include "global.h"

void setup()
{
  //pin setup
  pinMode(6,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(5,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(7,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(4,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(8,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(3,INPUT_ANALOG);  //int sensorSideRight
  
  pinMode(14,OUTPUT);  //int led
  pinMode(13,OUTPUT);  //int led
  pinMode(12,OUTPUT);  //int led
  
  pinMode(28,OUTPUT);  //int motorLeft+
  pinMode(29,OUTPUT);  //int motorLeft-
  pinMode(30,OUTPUT);  //int motorRight+
  pinMode(31,OUTPUT);  //int motorRight-

}

void loop()
{
  sensor.runAllSensor(currentStatus);
}

  
  






