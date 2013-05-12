#include "maze.h"


/*=======================================================  decide  =======================================================*/
int Maze::decide()
{
  /*------------------------------------------  set scenario  ------------------------------------------*/
  status.scenarioPath = 0;
  if(status.cellCurrent->wall[(status.compass+north) % 4] == false)  status.scenarioPath += openNorth;
  if(status.cellCurrent->wall[(status.compass+east) % 4] == false)  status.scenarioPath += openEast;
  if(status.cellCurrent->wall[(status.compass+west) % 4] == false)  status.scenarioPath += openWest;
  
  /*------------------------------------------  single open  ------------------------------------------*/
  if(status.scenarioPath == openNone)  motor.rotateBack();
  if(status.scenarioPath == openNorth)  motor.goStraight(speedMap);
  if(status.scenarioPath == openEast)  motor.rotateRight();
  if(status.scenarioPath == openWest)  motor.rotateLeft();
  
  /*------------------------------------------  multiple open  ------------------------------------------*/
  if(status.scenarioPath == openNorthEast) //FrontRight
  {
    if (returnBranch) //Return to current branch by going straight. (Already turned)
    {
      motor.goStraight(speedMap);
      return 0;
    }
    if (status.cellCurrent->visit == false)    //Sets Branch Value and Compass Home
    {
      status.cellCurrent->compassHome = (status.compass+2) % 4;
      status.cellCurrent->branch = branchValue;
      branchValue++;
    }
    switch (status.compass)
    {
      case north:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellNorth->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellEast->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case east:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellEast->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellSouth->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case south:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellSouth->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellWest->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case west:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellWest->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellNorth->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
    }
    return 0;
  }
  
  
  if(status.scenarioPath == openNorthWest)  //FrontLeft
  {
    if (returnBranch) //Return to current branch by going straight. (Already turned)
    {
      motor.goStraight(speedMap);
      return 0;
    }
    if (status.cellCurrent->visit == false)    //Sets Branch Value and Compass Home
    {
      status.cellCurrent->compassHome = (status.compass+2) % 4;
      status.cellCurrent->branch = branchValue;
      branchValue++;
    }
    switch (status.compass)
    {
      case north:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellNorth->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellWest->visit == false)  motor.rotateLeft();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case east:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellEast->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellNorth->visit == false)  motor.rotateLeft();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case south:
        if(status.cellCurrent->branch == (branchValue-1))
        {  
          if(status.cellCurrent->cellSouth->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellEast->visit == false)  motor.rotateLeft();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case west:
        if(status.cellCurrent->branch == (branchValue-1))
        {  
          if(status.cellCurrent->cellWest->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellSouth->visit == false)  motor.rotateLeft();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
    }
    return 0;
  }
  
  if(status.scenarioPath == openEastWest)
  {
    if (returnBranch) //Return to current branch by going straight. (Already turned)
    {
      motor.goStraight(speedMap);
      return 0;
    }
    if (status.cellCurrent->visit == false)    //Sets Branch Value and Compass Home
    {
      status.cellCurrent->compassHome = (status.compass+2) % 4;
      status.cellCurrent->branch = branchValue;
      branchValue++;
    }
    switch (status.compass)
    {
      case north:
        if(status.cellCurrent->branch == (branchValue-1))
        {  
          if(status.cellCurrent->cellWest->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellEast->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case east:
        if(status.cellCurrent->branch == (branchValue-1))
        {  
          if(status.cellCurrent->cellNorth->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellSouth->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case south:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellEast->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellWest->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case west:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellSouth->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellNorth->visit == false)  motor.rotateRight();
          else goHome();
        }
        else 
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
    }
    return 0;
  }
  
  if(status.scenarioPath == openAll)
  {
    if (returnBranch) //Return to current branch by going straight. (Already turned)
    {
      motor.goStraight(speedMap);
      return 0;
    }
    if (status.cellCurrent->visit == false)    //Sets Branch Value and Compass Home
    {
      status.cellCurrent->compassHome = (status.compass+2) % 4;
      status.cellCurrent->branch = branchValue;
      branchValue++;
    }
    switch (status.compass)
    {
      case north:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellNorth->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellWest->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellEast->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case east:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellEast->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellNorth->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellSouth->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
      case south:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellSouth->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellEast->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellWest->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }   
        break;
      case west:
        if(status.cellCurrent->branch == (branchValue-1))
        {
          if(status.cellCurrent->cellWest->visit == false)  motor.goStraight(speedMap);
          else if(status.cellCurrent->cellSouth->visit == false)  motor.rotateLeft();
          else if(status.cellCurrent->cellNorth->visit == false)  motor.rotateRight();
          else goHome();
        }
        else
        {
          motor.rotateBack();
          returnBranch = true;
        }
        break;
    }
    return 0;
  }
  return 0;
}



/*=======================================================  mapping  =======================================================*/
void Maze::mapping()
{
  /*------------------------------------------  set position  ------------------------------------------*/
  int cellTraveled = (status.countLeft+status.countRight) /2 / countCell;
  volatile Cell *cellMarker = status.cellCurrent;
  
  /*------------------------------------------  mark go one cell forward  ------------------------------------------*/
  if(cellTraveled > 0)
  {
    if(status.compass==north)  cellMarker = cellMarker->cellNorth;
    if(status.compass==east)  cellMarker = cellMarker->cellEast;
    if(status.compass==south)  cellMarker = cellMarker->cellSouth;
    if(status.compass==west)  cellMarker = cellMarker->cellWest;
    cellTraveled--;
  }

  /*------------------------------------------  loop traveled  ------------------------------------------*/
  while(cellTraveled>0)
  {
    cellMarker->wall[(status.compass+east) % 4] = true;
    cellMarker->wall[(status.compass+west) % 4] = true;
    cellMarker->visit = true;
    adjacentWall(cellMarker);
    cellMarker->visit = true;
    if(status.compass==north)  cellMarker = cellMarker->cellNorth;
    if(status.compass==east)  cellMarker = cellMarker->cellEast;
    if(status.compass==south)  cellMarker = cellMarker->cellSouth;
    if(status.compass==west)  cellMarker = cellMarker->cellWest;
    cellTraveled--;
  }
  
  /*------------------------------------------  set arrived cell  ------------------------------------------*/
  if(status.distFront < distWallExist)  cellMarker->wall[(status.compass+north) % 4] = true;
  if(status.distSideRight < distWallExist)  cellMarker->wall[(status.compass+east) % 4] = true;
  if(status.distSideLeft < distWallExist)  cellMarker->wall[(status.compass+west) % 4] = true;
  adjacentWall(cellMarker);
  cellMarker->visit = true;
  status.cellCurrent = cellMarker;
  
  /*------------------------------------------  aquire instruction  ------------------------------------------*/
  status.mode = modeDecide;
}

/*------------------------------------------  update adjacent  ------------------------------------------*/
void Maze::adjacentWall(volatile Cell *cellMarker)
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


/*------------------------------------------ decide mini-functions ------------------------------------*/

void Maze::goHome()
{
  switch (status.compass)
  {
    case north:
        if(status.cellCurrent->compassHome == north) /*will move forward*/ ;
        if(status.cellCurrent->compassHome == east)  motor.rotateRight();
        if(status.cellCurrent->compassHome == south) motor.rotateBack();
        if(status.cellCurrent->compassHome == west)  motor.rotateLeft();
        branchValue--;
        break;
    case east:
        if(status.cellCurrent->compassHome == east) /*will move forward*/ ;
        if(status.cellCurrent->compassHome == south)  motor.rotateRight();
        if(status.cellCurrent->compassHome == west) motor.rotateBack();
        if(status.cellCurrent->compassHome == north)  motor.rotateLeft();
        branchValue--;    
        break;
    case south:
        if(status.cellCurrent->compassHome == south) /*will move forward*/ ;
        if(status.cellCurrent->compassHome == west)  motor.rotateRight();
        if(status.cellCurrent->compassHome == north) motor.rotateBack();
        if(status.cellCurrent->compassHome == east)  motor.rotateLeft();
        branchValue--;   
        break;
    case west:
        if(status.cellCurrent->compassHome == west) /*will move forward*/ ;
        if(status.cellCurrent->compassHome == north)  motor.rotateRight();
        if(status.cellCurrent->compassHome == east) motor.rotateBack();
        if(status.cellCurrent->compassHome == south)  motor.rotateLeft();
        branchValue--;
        break;
  }
  returnBranch = true; //Sets flag to go straight.
}


/*=======================================================  flood fill  =======================================================*/
void Maze::flood()
{
  //All cells floodValues are initially set to -1. Set Center to 0.
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
      cell[y][x].floodValue = -1;
    } 
  
  /*------------------------------------------  goal  ------------------------------------------*/
  cell[mazeSize/2-1][mazeSize/2-1].goal = true;
  cell[mazeSize/2-1][mazeSize/2].goal = true;
  cell[mazeSize/2][mazeSize/2-1].goal = true;
  cell[mazeSize/2][mazeSize/2].goal = true;
  
  /*------------------------------------------  start cell  ------------------------------------------*/
  cell[0][0].wall[south] = true;
  cell[0][0].wall[east] = true;
  cell[0][0].wall[west] = true;
    
  /*------------------------------------------  empty cell  ------------------------------------------*/
  emptyCell.x = -1;
  emptyCell.y = -1;
  emptyCell.visit = false;
  for(int i=0; i<4; i++) emptyCell.wall[i] = false;
  emptyCell.goal = false;
  emptyCell.existance = false;
  
  /*------------------------------------------ initial values --------------------------------------------*/
  branchValue = 1;
  returnBranch = false;
}

