
#include "maze.h"

/*===================  public functions  =======================*/
void Maze::mapping()
{
  int speed = mappingSpeed;
  while(status.currentCell.goal == false)
  {
    while(status.sideLeftDist < wallExistDist && status.sideRightDist < wallExistDist)
      motor.gostraight(speed);
    //taking the wheel count average
    int wheelCount = (wheelCountLeft + wheelCountRight)/2;
    //set wall
    for(int i=0; i<(wheelCount/cellLength); i++)
    {
      cell[i].wall[0]=false;
      cell[i].wall[1]=true;
      cell[i].wall[2]=false;
      cell[i].wall[3]=true;      
    }
    
    //turn right or left then loop until reach goal
  }
}




/*===================  private functions  =======================*/
void Maze::setWall()
{
  

}


/*===================  initialize functions  =======================*/
void Maze::initialize()
{
  //for all cell
  for(int y=0; y<16; y++)
    for(int x=0; x<16; x++)
    {
      //set visit and wall value to false
      cell.x = x;
      cell.y = y;
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


