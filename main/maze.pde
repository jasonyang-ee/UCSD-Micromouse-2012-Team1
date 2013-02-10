
#include "maze.h"

void Maze::initialize()
{
  //for all cell
  for(int y=0; y<16; y++)
    for(int x=0; x<16; x++)
    {
      //Visit and wall value
      cell[y][x].visit = false;
      for(int i=0; i<4; i++) cell[y][x].wall[i] = false;
      
      //Flood Valu
      //Initialize with 0 in four goal cell, and increase for every adjacent cell
      if(y<=7)
      {
        if(x<=7)
          cell[y][x].floodValue = 14-x-y;   //Quad III
        else if(x>=8)
          cell[y][x].floodValue = x-y-1;    //Quad IV
      }
      else if(y>=8)
      {
        if(x<=7)
          cell[y][x].floodValue = y-x-1;    //Quad II
        else if(x>=8)
          cell[y][x].floodValue = x+y-16;   //Quad I
      }
    }
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


