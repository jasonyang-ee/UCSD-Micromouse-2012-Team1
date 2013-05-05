#include "maze.h"


/*=======================================================  decide  =======================================================*/
int Maze::decide(int scenario)
{
  
  
}



/*=======================================================  mapping  =======================================================*/
void Maze::mapping()
{
  /*------------------------------------------  set position  ------------------------------------------*/
  int cellTraveled = status.countLeft / countCell;
  Cell *cellMarker = status.currentCell; 
  
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
}

void Maze::adjacentWall(Cell *cellMarker)
{
  Cell *adjacentNorth=cellMarker->cellNorth;
  Cell *adjacentEast=cellMarker->cellEast;
  Cell *adjacentSouth=cellMarker->cellSouth;
  Cell *adjacentWest=cellMarker->cellWest;
  if(cellMarker->wall[north]==true)  adjacentNorth->wall[south]=true;
  if(cellMarker->wall[east]==true)  adjacentNorth->wall[west]=true;
  if(cellMarker->wall[south]==true)  adjacentNorth->wall[north]=true;
  if(cellMarker->wall[west]==true)  adjacentNorth->wall[east]=true;
}


/*=======================================================  flood fill  =======================================================*/
void Maze::floodFill()
{
  
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

