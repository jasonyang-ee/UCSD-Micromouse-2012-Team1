#include "HEAD_h"
#include "maze_h"
#include "maze.h"
#include "sensor.h"
#include "motor.h"

void setup()
{
  //pin setup
  pinMode(1,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(2,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(3,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(4,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(5,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(6,INPUT_ANALOG);  //int sensorSideRight
  
  pinMode(9,OUTPUT);  //int ledFrontLeft
  pinMode(10,OUTPUT);  //int ledFrontRight
  pinMode(11,OUTPUT);  //int ledDiagonalLeft
  pinMode(12,OUTPUT);  //int ledDiagonalRight
  pinMode(13,OUTPUT);  //int ledSideLeft
  pinMode(14,OUTPUT);  //int ledSideRight
  
  pinMode(7,OUTPUT);  //int motorLeft
  pinMode(8,OUTPUT);  //int motorRight
  
  //interrupt
  void attachInterrupt(9, sensorRead(), RISING);
  void attachInterrupt(10, sensorRead(), RISING);
  void attachInterrupt(11, sensorRead(), RISING);
  void attachInterrupt(12, sensorRead(), RISING);
  void attachInterrupt(13, sensorRead(), RISING);
  void attachInterrupt(14, sensorRead(), RISING);
}

void loop()
{
  blinkLED();
  
  
  
}

  
  






