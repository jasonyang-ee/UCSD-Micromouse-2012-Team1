#ifndef HEAD_H
#define HEAD_H

//setting size of maze
#define WIDTH = 16
#define LENGTH = 16

//Reciever
int sensorFrontLeft = 1;
int sensorFrontRight = 2;
int sensorDiagonalLeft = 3;
int sensorDiagonalRight = 4;
int sensorSideLeft = 5;
int sensorSideRight = 6;

//IR LED
int ledFrontLeft = 9;
int ledFrontRight = 10;
int ledDiagonalLeft = 11;
int ledDiagonalRight = 12;
int ledSideLeft = 13;
int ledSideRight = 14;

//motor
int motorLeft = 7;
int motorRight = 8;

//calling object of the class
MAZE maze;
SENSOR sensor;
MOTOR motor;
CELL cell[LENGTH][WIDTH];  //CELL cell[y][x];



#endif
