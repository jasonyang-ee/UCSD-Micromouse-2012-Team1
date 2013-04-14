#ifndef GLOBAL_H
#define GLOBAL_H

#include "cell.h"
#include "maze.h"
#include "motor.h"
#include "sensor.h"
#include "status.h"

/*================== Maze Constant ====================*/
#define mazeSize 16 //cells

/*================== Sensor Constant ====================*/
#define cellLength 18 //cm

/*================== Sensor Constant ====================*/

//sensor interrupt
#define sensorRate 5      // in period, 1 period = 1 ms

//sensor sample rate and sample numbers
#define sampleNum 20

//minimun distance between wall and mouse in one cell
#define wallExistDist 7


/*================== Motor Constant ====================*/

//for fixOrientation
#define orientationConstant 1800 //for mapping, might need to
                                 //increase for speed run
#define deviationConstant 10

//speed constant
#define turnRatio 6/15
#define driveRatio 6/15
#define fullSpeed 65536
#define mappingSpeed 5000
#define turnSpeed 3000
#define turnCount 23
#define UturnCount 56


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

//motor
#define PWMLeft 15
#define motorLeft1 22    //motorLeft +  LOW    }gives forward
#define motorLeft2 21    //motorLeft -  HIGH   }
#define PWMRight 27
#define motorRight1 25   //motorRight + HIGH   }gives forward
#define motorRight2 26   //motorRight - LOW    }

//encoder
#define encoderLeftDirc 31
#define encoderLeftCLK 30
#define encoderRightDirc 18
#define encoderRightCLK 16

/*================== object declear ====================*/
Maze maze;
Sensor sensor;
Motor motor;
Cell cell[16][16];  //CELL cell[y][x];
Cell emptyCell;
Status status;
Status oldStatus[10];

/*================== mouse state ====================*/
bool initializeState = false;
bool mappingState = false;

#endif
