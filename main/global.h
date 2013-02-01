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
#define sensorFrontLeft 1
#define sensorFrontRight 2
#define sensorDiagonalLeft 3
#define sensorDiagonalRight 4
#define sensorSideLeft 5
#define sensorSideRight 6

//IR LED
#define ledFrontLeft 9
#define ledFrontRight 10
#define ledDiagonalLeft 11
#define ledDiagonalRight 12
#define ledSideLeft 13
#define ledSideRight 14

//motor
#define motorLeft 7
#define motorRight 8

//object declear
Maze maze;
Sensor sensor;
Motor motor;
Cell cell[LENGTH][WIDTH];  //CELL cell[y][x];
Status currentStatus;
Status prevStatus;

#endif
