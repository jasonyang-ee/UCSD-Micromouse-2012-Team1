
#include "maze.h"

/*===================  public functions  =======================*/
void Maze::mapping()
{
  
  
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
  setWall();
}

/*===================  debug functions  =======================*/

void Maze::printAll()
{
//print all status variable for debug 
}


