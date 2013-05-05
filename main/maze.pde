#include "maze.h"


/*=======================================================  decide  =======================================================*/
void Maze::decide()
{
  /*------------------------------------------  set home path  ------------------------------------------*/
  status.cellCurrent->compassHome = (status.compass+2) % 4;
  
  /*------------------------------------------  set scenario  ------------------------------------------*/
  status.scenarioDecide = 0;
  if(status.cellCurrent->wall[(status.compass+north) % 4] == false)  status.scenarioDecide += openNorth;
  if(status.cellCurrent->wall[(status.compass+east) % 4] == false)  status.scenarioDecide += openEast;
  if(status.cellCurrent->wall[(status.compass+west) % 4] == false)  status.scenarioDecide += openWest;
  
  /*------------------------------------------  instruction  ------------------------------------------*/
  if(status.scenarioDecide == openNone)  motor.rotateBack(speedMap);
  if(status.scenarioDecide == openNorth)  motor.goStraight(speedMap);
  if(status.scenarioDecide == openEast)  motor.rotateRight(speedMap);
  if(status.scenarioDecide == openWest)  motor.rotateLeft(speedMap);
  
  if(status.scenarioDecide == openNorthEast)
  {
    if(status.cellCurrent->cellNorth->visit == false)  motor.goStraight(speedMap);
    else if(status.cellCurrent->cellEast->visit == false)  motor.rotateLeft(speedMap);
    else
    {
      if(status.cellCurrent->compassHome == north)  motor.goStraight(speedMap);
      if(status.cellCurrent->compassHome == east)  motor.rotateRight(speedMap);
      if(status.cellCurrent->compassHome == west)  motor.rotateLeft(speedMap);
    }
  }
  if(status.scenarioDecide == openNorthWest)
  {
    if(status.cellCurrent->cellNorth->visit == false)  motor.goStraight(speedMap);
    else if(status.cellCurrent->cellWest->visit == false)  motor.rotateRight(speedMap);
    else
    {
      if(status.cellCurrent->compassHome == north)  motor.goStraight(speedMap);
      if(status.cellCurrent->compassHome == east)  motor.rotateRight(speedMap);
      if(status.cellCurrent->compassHome == west)  motor.rotateLeft(speedMap);
    }
  }
  if(status.scenarioDecide == openEastWest)
  {
    if(status.cellCurrent->cellEast->visit == false)  motor.rotateLeft(speedMap);
    else if(status.cellCurrent->cellWest->visit == false)  motor.rotateRight(speedMap);
    else
    {
      if(status.cellCurrent->compassHome == north)  motor.goStraight(speedMap);
      if(status.cellCurrent->compassHome == east)  motor.rotateRight(speedMap);
      if(status.cellCurrent->compassHome == west)  motor.rotateLeft(speedMap);
    }
  }
  if(status.scenarioDecide == openAll)
  {
    if(status.cellCurrent->cellNorth->visit == false)  motor.goStraight(speedMap);
    else if(status.cellCurrent->cellEast->visit == false)  motor.rotateLeft(speedMap);
    else if(status.cellCurrent->cellWest->visit == false)  motor.rotateRight(speedMap);
    else
    {
      if(status.cellCurrent->compassHome == north)  motor.goStraight(speedMap);
      if(status.cellCurrent->compassHome == east)  motor.rotateRight(speedMap);
      if(status.cellCurrent->compassHome == west)  motor.rotateLeft(speedMap);
    }
  }
}



/*=======================================================  mapping  =======================================================*/
void Maze::mapping()
{
  /*------------------------------------------  set position  ------------------------------------------*/
  int cellTraveled = status.countLeft / countCell;
  Cell *cellMarker = status.cellCurrent; 
  
  /*------------------------------------------  set arrived cell  ------------------------------------------*/
  if(status.distFront < 10)  cellMarker->wall[(status.compass+north) % 4] = true;
  if(status.distSideRight < 10)  cellMarker->wall[(status.compass+east) % 4] = true;
  if(status.distSideLeft < 10)  cellMarker->wall[(status.compass+west) % 4] = true;
  adjacentWall(cellMarker);
  cellMarker->visit = true;
  
  /*------------------------------------------  go one cell back  ------------------------------------------*/
  if(status.compass==north)  cellMarker = cellMarker->cellSouth;
  if(status.compass==east)  cellMarker = cellMarker->cellWest;
  if(status.compass==south)  cellMarker = cellMarker->cellNorth;
  if(status.compass==west)  cellMarker = cellMarker->cellEast;
  
  /*------------------------------------------  loop traveled  ------------------------------------------*/
  while(cellTraveled>=0)
  {
    cellMarker->wall[(status.compass+east) % 4] = true;
    cellMarker->wall[(status.compass+west) % 4] = true;
    adjacentWall(cellMarker);
    cellMarker->visit = true;
    if(status.compass==north)  cellMarker = cellMarker->cellSouth;
    if(status.compass==east)  cellMarker = cellMarker->cellWest;
    if(status.compass==south)  cellMarker = cellMarker->cellNorth;
    if(status.compass==west)  cellMarker = cellMarker->cellEast;
    cellTraveled--;
  }
  
  /*------------------------------------------  aquire instruction  ------------------------------------------*/
  status.mode = modeWait;
}

/*------------------------------------------  update adjacent  ------------------------------------------*/
void Maze::adjacentWall(Cell *cellMarker)
{
  Cell *adjacentNorth=cellMarker->cellNorth;
  Cell *adjacentEast=cellMarker->cellEast;
  Cell *adjacentSouth=cellMarker->cellSouth;
  Cell *adjacentWest=cellMarker->cellWest;
  if(cellMarker->wall[north]==true)  adjacentNorth->wall[south]=true;
  if(cellMarker->wall[east]==true)  adjacentEast->wall[west]=true;
  if(cellMarker->wall[south]==true)  adjacentSouth->wall[north]=true;
  if(cellMarker->wall[west]==true)  adjacentWest->wall[east]=true;
}


/*=======================================================  flood fill  =======================================================*/
void Maze::flood()
{
  //All cells floodValues are initially set to -1.
  cell[mazeSize/2-1][mazeSize/2-1].floodValue = 0;
  cell[mazeSize/2-1][mazeSize/2].floodValue = 0;
  cell[mazeSize/2][mazeSize/2-1].floodValue = 0;
  cell[mazeSize/2][mazeSize/2].floodValue = 0;
  for (int curr_step=1; curr_step < mazeSize*mazeSize; curr_step++)
    for (int y=0; y<mazeSize; y++)
      for (int x=0; x<mazeSize; x++)
        if (cell[y][x].visit == true && cell[y][x].floodValue == (curr_step - 1))
          expand(y, x, curr_step);
}

//Checks all four directions to see if there is a wall blocking.
void Maze::expand(int y, int x, int curr_step)
{
  northFlood(y, x, curr_step);
  eastFlood(y, x, curr_step);
  southFlood(y, x, curr_step);
  westFlood(y, x, curr_step);
}

void Maze::northFlood(int y, int x, int curr_step) 
{
  if ((y < 15) && !(cell[y][x].wall[0]))
    if(cell[y+1][x].floodValue < 0)
      cell[y+1][x].floodValue = curr_step; 
}

void Maze::eastFlood(int y, int x, int curr_step) 
{
  if (x < 15 && !(cell[y][x].wall[1]))
    if (cell[y][x+1].floodValue < 0)
      cell[y][x+1].floodValue = curr_step;
}

void Maze::southFlood(int y, int x, int curr_step) 
{
  if (y > 0 && !(cell[y][x].wall[2])) 
    if (cell[y-1][x].floodValue < 0) 
      cell[y-1][x].floodValue = curr_step;
}

void Maze::westFlood(int y, int x, int curr_step) 
{
  if (x > 0 && !(cell[y][x].wall[3]) )
    if (cell[y][x-1].floodValue < 0) 
      cell[y][x-1].floodValue = curr_step;
}


/*=======================================================  initialize  =======================================================*/
void Maze::initialize()
{  
  /*------------------------------------------  set sibling  ------------------------------------------*/
  for(int y=0; y<mazeSize; y++)
    for(int x=0; x<mazeSize; x++)
    {
      if(y+1 < mazeSize)
        cell[y][x].cellNorth = &cell[y+1][x];
      else  cell[y][x].cellNorth = &emptyCell;
      if(y-1 >= 0)
        cell[y][x].cellSouth = &cell[y-1][x];
      else  cell[y][x].cellSouth = &emptyCell;
      if(x+1 < mazeSize)
        cell[y][x].cellEast = &cell[y][x+1];
      else  cell[y][x].cellEast = &emptyCell;
      if(x-1 >= 0)
        cell[y][x].cellWest = &cell[y][x-1];
      else  cell[y][x].cellWest = &emptyCell;
    }
  
  /*------------------------------------------  basic element  ------------------------------------------*/
  for(int y=0; y<16; y++)
    for(int x=0; x<16; x++)
    {
      cell[y][x].x=x;
      cell[y][x].y=y;
      cell[y][x].visit = false;
      for(int i=0; i<4; i++)  cell[y][x].wall[i] = false;
      cell[y][x].goal = false;
      cell[y][x].existance = true;
      cell[y][x].dead = false;
    } 
  
  /*------------------------------------------  goal  ------------------------------------------*/
  cell[mazeSize/2-1][mazeSize/2-1].goal = true;
  cell[mazeSize/2-1][mazeSize/2].goal = true;
  cell[mazeSize/2][mazeSize/2-1].goal = true;
  cell[mazeSize/2][mazeSize/2].goal = true;
  
  /*------------------------------------------  flood value  ------------------------------------------*/
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
    
  /*------------------------------------------  empty cell  ------------------------------------------*/
  emptyCell.x = -1;
  emptyCell.y = -1;
  emptyCell.visit = false;
  for(int i=0; i<4; i++) emptyCell.wall[i] = false;
  emptyCell.goal = false;
  emptyCell.existance = false;
}

