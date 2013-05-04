#ifndef GLOBAL_H
#define GLOBAL_H

#include "cell.h"
#include "maze.h"
#include "motor.h"
#include "sensor.h"
#include "status.h"

/*=====================  maze constant  =====================*/
//cell per side
#define mazeSize 16
#define countCell 

/*=====================  sensor constant  =====================*/
//counter++ for every 1us, and interrupt for every 1000 count
//interrupt in every 1us * this value = period
#define timerRate 100

//sensor sample rate and sample numbers
#define sampleNum 20

//minimun distance between wall and mouse in one cell
#define distWallExist 13

/*=====================  motor constant  =====================*/
//speed constant
#define speedFull 65536
#define speedMap 10000
#define speedRotate 10000
#define speedTurn 10000

#define turnRatio 6/15

#define rotateCount 95
#define rotateBackCount 250
#define turnCount 300

/*=====================  pin constant  =====================*/
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
#define encoderLeftDirc 18
#define encoderLeftCLK 16
#define encoderRightDirc 31
#define encoderRightCLK 30

/*=====================  object declare  =====================*/
Maze maze;
Sensor sensor;
Motor motor;
Cell cell[16][16];  //CELL cell[y][x];
Cell emptyCell;
Status status;

/*=====================  mode value  =====================*/
//mode
#define modeStop 0
#define modeDecelerate 1
#define modeStraight 2
#define modeRotate 3
#define modeTurn 4
#define modeWait 5

//scenarioStraight
#define modeNull 0
#define followRight 1
#define followLeft 2
#define followBoth 3
#define fishBone 4

//scenarioRotate
//scenarioTurn
#define left 1
#define right 2
#define back 3


#endif
