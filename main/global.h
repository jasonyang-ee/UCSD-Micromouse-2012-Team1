#ifndef GLOBAL_H
#define GLOBAL_H

#include "cell.h"
#include "maze.h"
#include "motor.h"
#include "sensor.h"
#include "status.h"

//sensor interrupt
#define sensorRate 1      // in period, 1 period = 1 ms

//sensor sample rate and sample numbers
#define sampleNum 20
#define sampleRate 1

//minimun distance between wall and mouse in one cell
#define wallExistDist 5

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
#define PWMLeft 25
#define motorLeft1 21
#define motorLeft2 22
#define PWMRight 15
#define motorRight1 18
#define motorRight2 19
#define STBY 20

//object declear
Maze maze;
Sensor sensor;
Motor motor;
Cell cell[16][16];  //CELL cell[y][x];
Status status;
Status oldStatus[10];

#endif
