int IR  = 13;
int sensor = 5;
double value, average, distance, darkValue, darkDistance;
//motor
#define PWMLeft 25
#define motorLeft1 21    //motorLeft +  LOW    }gives forward
#define motorLeft2 22    //motorLeft -  HIGH   }
#define PWMRight 15
#define motorRight1 18   //motorRight + HIGH   }gives forward
#define motorRight2 19   //motorRight - LOW    }
#ifndef GLOBAL_H
#define GLOBAL_H

#include "cell.h"
#include "maze.h"
#include "motor.h"
#include "sensor.h"
#include "status.h"

/*================== Sensor Constant ====================*/

//sensor interrupt
#define sensorRate 1      // in period, 1 period = 1 ms

//sensor sample rate and sample numbers
#define sampleNum 20
#define sampleRate 1

//minimun distance between wall and mouse in one cell
#define wallExistDist 50


/*================== Motor Constant ====================*/

//orientation speed constant for fixOrientation
#define orientationConstant 10
#define deviationConstant 10
#define turnRatio 10
#define fullSpeed 65535



/*================== Pin Constant ====================*/

//Reciever
#define sensorFrontLeft 6
#define sensorFrontRight 5
#define sensorDiagonalLeft 7
#define sensorDiagonalRight 4
#define sensorSideLeft 8
#define sensorSideRight 3

//IR LED
#define ledOne 12
#define ledTwo 13
#define ledThree 14

//encoder
#define encoderLeftDirc 31
#define encoderLeftCLK 30
#define encoderRightDirc 29
#define encoderRightCLK 28

//object declear
Maze maze;
Sensor sensor;
Motor motor;
Cell cell[16][16];  //CELL cell[y][x];
Status status;
Status oldStatus[10];

//initializer
bool initialize = false;

#endif
#define STBY 20

void setup()
{
  pinMode(sensorFrontLeft,INPUT_ANALOG);  //int sensorFrontLeft
  pinMode(sensorFrontRight,INPUT_ANALOG);  //int sensorFrontRight
  pinMode(sensorDiagonalLeft,INPUT_ANALOG);  //int sensorDiagonalLeft
  pinMode(sensorDiagonalRight,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(sensorSideLeft,INPUT_ANALOG);  //int sensorSideLeft
  pinMode(sensorSideRight,INPUT_ANALOG);  //int sensorSideRight
  pinMode(IR, OUTPUT);
  pinMode(sensor, INPUT_ANALOG);
  digitalWrite(IR, HIGH);
}

void loop()
{
  
  togglePin(IR);
  average=0;
  for(int i=0; i<5; i++)
  {
    value = analogRead(sensor);
    average += value;
    delay(5);
  }
  average /= 5; 
 
  distance = (1 / pow(average, 2))*1000;
  

  SerialUSB.print("V = ");
  SerialUSB.print(average);
  SerialUSB.print("\tX = ");
  SerialUSB.print(distance);
  SerialUSB.print("\n");
  
  delay(300);
}
