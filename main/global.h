#ifndef GLOBAL_H
#define GLOBAL_H

#include "cell.h"
#include "maze.h"
#include "motor.h"
#include "sensor.h"
#include "status.h"

//setting size of maze
#define WIDTH 16
#define LENGTH 16

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
#define motorLeftP 28
#define motorLeftN 29
#define motorRightP 30
#define motorRightN 31

//object declear
Maze maze;
Sensor sensor;
Motor motor;
Cell cell[LENGTH][WIDTH];  //CELL cell[y][x];
Status currentStatus;
Status prevStatus;

#endif
