#ifndef HEAD_H
#define HEAD_H

//setting size of maze
#define WIDTH = 16
#define LENGTH = 16

//sensor sample rate and sample numbers
#define sampleNum 20
#define sampleRate 1

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

//calling object of the class
MAZE maze;
SENSOR sensor;
MOTOR motor;
CELL cell[LENGTH][WIDTH];  //CELL cell[y][x];

#endif
