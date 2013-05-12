#include "racing.h"

/*---------------------------------------------Easy Run----------------------------------------------*/
void Racing::easyRun(int speed)     //Easy way to do this, one cell at a time (and straight-ways)
{ 
  int cellTraveled = ((status.countLeft+status.countRight) /2) / countCell;
  for (int i = cellTraveled; i > 0; i--)
  {
    if(status.compass==north)  status.cellCurrent = status.cellCurrent->cellNorth;
    if(status.compass==east)  status.cellCurrent = status.cellCurrent->cellEast;
    if(status.compass==south)  status.cellCurrent = status.cellCurrent->cellSouth;
    if(status.compass==west)  status.cellCurrent = status.cellCurrent->cellWest;
  }
  
  if(status.cellCurrent->goal == false)   //Goes one cell at a time
  {
    step = status.cellCurrent->floodValue;
    int nextStep = step - 1;
    
    volatile Cell *cellMarker = status.cellCurrent;
    
    neighbor (cellMarker);
    
    if (rightCell->floodValue == nextStep)     motor.rotateRight();
    else if (leftCell->floodValue == nextStep) motor.rotateLeft();
    else if (frontCell->floodValue == nextStep)motor.goStraight(speed);
  }
  else if (status.cellCurrent->goal == true) ;//Set mode to Home Run?
  
}

/*---------------------------------------Home Run-------------------------------------*/
void Racing::homeRun(int speed)   //From Home to Center, walk back
{
  
  

  
  
  
}

/*----------------------------------- Speed Run --------------------------------------*/

/*
void Racing::speedRun(int speed)
{
  status.cellCurrent = &cell[0][0]; //Resets current cell to starting cell
  
  step = cell[0][0].floodValue;  //Sets current step
  
  numbStraight = 0;
  nextRight = false;
  nextLeft = false;
  
  while (status.cellCurrent->goal == false)
  {
    next(status.cellCurrent); //Decides next movements and updates position within
    
    while ((status.countLeft/countCell) < (numbStraight-1))  //Goes to the cell right before the turn so that it can turn while going straight
      motor.goStraight (speed); //Accelerating Straight Function for Straight-ways Needed      
    if (nextRight)
      motor.turnRight(speed); //Turns Right while going Straight
    else if (nextLeft)
      motor.turnLeft(speed); //Turns Left while going Straight   
  }
}



void Racing::next(Cell *cellMarker)
{
  step--;
  
  neighbor (cellMarker);
  
  if(frontCell->floodValue == step)
  {
    while (frontCell->floodValue == step)
    {
      numbStraight++;
      cellMarker = frontCell;
      neighbor (cellMarker);
      step--;
    }
    
    if (rightCell->floodValue == step)
    {
      cellMarker = rightCell;
      
      neighbor
      
      step--;
    }
    else if (leftCell->floodValue == step)
    {
      nextLeft = true;
      cellMarker = leftCell;
      step--;
    }
  }
    
  status.cellCurrent = cellMarker;   
}
*/

/*-----------------------------------------------Sub-Functions-------------------------------------------------*/

void Racing::neighbor(volatile Cell *cellMarker)
{
  switch (status.compass)  //Sets Neighboring Cells
    {
      case north:
        frontCell = cellMarker->cellNorth;
        rightCell = cellMarker->cellEast;
        leftCell = cellMarker->cellWest;
        break;
      case east:
        frontCell = cellMarker->cellEast;
        rightCell = cellMarker->cellSouth;
        leftCell = cellMarker->cellNorth;
        break;
      case south:
        frontCell = cellMarker->cellSouth;
        rightCell = cellMarker->cellWest;
        leftCell = cellMarker->cellEast;
        break;
      case west:
        frontCell = cellMarker->cellWest;
        rightCell = cellMarker->cellNorth;
        leftCell = cellMarker->cellSouth;
        break;
    }
}

void Racing::initialize()
{
  status.cellCurrent = &cell[0][0]; //Resets current cell to starting cell
}
