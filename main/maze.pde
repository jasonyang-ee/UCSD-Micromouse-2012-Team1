
#include "maze.h"

void Maze::initialize()
{
//initialize function
}

void Maze::setWall()
{
  //if current distance with wall < the calibrated distance, then wall exist
  if(status.frontDist < wallExistDist)
    status.currentCell.wall[(status.compass+0)%4] = true;
  if(status.sideLeftDist < wallExistDist)
    status.currentCell.wall[(status.compass+3)%4] = true;
  if(status.sideRightDist < wallExistDist)
    status.currentCell.wall[(status.compass+1)%4] = true;
}







/*===================  debug functions  =======================*/

void Maze::printAll()
{
//print all status variable for debug 
}


