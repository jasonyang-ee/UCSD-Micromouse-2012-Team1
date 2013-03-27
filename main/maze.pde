
#include "maze.h"

/*===================  public functions  =======================*/
void Maze::mapping()
{
  int speed = mappingSpeed;
  while(status.currentCell.goal == false)
  {
    while(status.sideLeftDist < wallExistDist && status.sideRightDist < wallExistDist)
      motor.goStraight(speed);
    //taking the wheel count average
    int wheelCount = (status.wheelCountLeft + status.wheelCountRight)/2;
    //set wall
    for(int i=0; i<(wheelCount/cellLength); i++)
    {
      int x=0, y=0;
      cell[x][y].wall[0]=false;
      cell[x][y].wall[1]=true;
      cell[x][y].wall[2]=false;
      cell[x][y].wall[3]=true;      
    }
    
    //turn right or left then loop until reach goal
  }
  
  //set wall info for the 4 goal cells
  //then stop and turn back and map other place base on cell visit value
  //then go back to start cell[0][0]
}


/*===================  private functions  =======================*/

void Maze::floodFill()
{
  
  
}


/*===================  initialize functions  =======================*/
void Maze::initialize()
{
  //for all cell
  for(int y=0; y<16; y++)
    for(int x=0; x<16; x++)
    {
      //set xy, visit, and wall value to false
      cell[y][x].x=x;
      cell[y][x].y=y;
      cell[y][x].visit = false;
      for(int i=0; i<4; i++) cell[y][x].wall[i] = false;
      
      //Flood Valu
      //Initialize with 0 in four goal cell, and increase the value for every adjacent cell
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
    
  //setup wall value for cell[0][0]
  for(int i=1; i<4; i++)
    cell[0][0].wall[i]=true;
}


/*===================  debug functions  =======================*/

void Maze::printAll()
{
//print all status variable for debug 
}


