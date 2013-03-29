#ifndef GLOBAL_H
#define GLOBAL_H

#include "sensor.h"
#include "status.h"

/*================== Maze Constant ====================*/
#define mazeSize 16

/*================== Sensor Constant ====================*/
#define cellLength 18

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
#define mappingSpeed 500


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


/*================== object declear ====================*/
Sensor sensor;
Status status;
Status oldStatus[10];


#endif
