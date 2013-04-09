
#include "maze.h"

/*===================  public functions  =======================*/
void Maze::mapping()
{
  int speed = mappingSpeed;
  while(status.currentCell->goal == false)
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
  //assign siblings for every cells
  for(int y=0; y<16; y++)
    for(int x=0; x<16; x++)
    {
      if(y+1 < mazeSize)
        cell[y][x].north = &cell[y+1][x];
      else  cell[y][x].north = &emptyCell;
      if(y-1 > 0)
        cell[y][x].south = &cell[y-1][x];
      else  cell[y][x].south = &emptyCell;
      if(x+1 < mazeSize)
        cell[y][x].east = &cell[y][x+1];
      else  cell[y][x].east = &emptyCell;
      if(x-1 > 0)
        cell[y][x].west = &cell[y][x-1];
      else  cell[y][x].west = &emptyCell;
    }
  
  //initialize elements for every cells
  for(int y=0; y<16; y++)
    for(int x=0; x<16; x++)
    {
      cell[y][x].x=x;
      cell[y][x].y=y;
      cell[y][x].visit = false;
      for(int i=0; i<4; i++) cell[y][x].wall[i] = false;
      cell[y][x].goal = false;
      cell[y][x].existance = true;
    } 
  
  //assign goal to 4 cells
  cell[mazeSize/2-1][mazeSize/2-1].goal = true;
  cell[mazeSize/2-1][mazeSize/2].goal = true;
  cell[mazeSize/2][mazeSize/2-1].goal = true;
  cell[mazeSize/2][mazeSize/2].goal = true;
  
  //initialize flood fill values for every cells
  for(int y=0; y<16; y++)
    for(int x=0; x<16; x++)
    {
      if(y<=7)
      {
        if(x<=7)
          cell[y][x].floodValue = 14-x-y;   //quadrant III
        else if(x>=8)
          cell[y][x].floodValue = x-y-1;    //quadrant IV
      }
      else if(y>=8)
      {
        if(x<=7)
          cell[y][x].floodValue = y-x-1;    //quadrant II
        else if(x>=8)
          cell[y][x].floodValue = x+y-16;   //quadrant I
      }
    }
    
  //assign wall info to first cell
  for(int i=1; i<4; i++)
    cell[0][0].wall[i]=true;
    
  //initialize emptyCell
  emptyCell.x = -1;
  emptyCell.y = -1;
  emptyCell.visit = false;
  for(int i=0; i<4; i++) emptyCell.wall[i] = false;
  emptyCell.goal = false;
  emptyCell.existance = false;
}


/*===================  debug functions  =======================*/

void Maze::printAll()
{
//print all status variable for debug 
}


