#include "racing.h"

/*---------------------------------------------Easy Run----------------------------------------------*/
void Racing::easyRun(int speed)     //Easy way to do this, one cell at a time (and straight-ways) 
{ 
  //This function can be used both for going to center and returning home. (Based on FloodFill)
  
  int cellTraveled = ((status.countLeft+status.countRight) /2) / countCell;
  for (int i = cellTraveled; i > 0; i--)
  {
    if(status.compass==north)  status.currentCell = status.currentCell->cellNorth;
    if(status.compass==east)  status.currentCell = status.currentCell->cellEast;
    if(status.compass==south)  status.currentCell = status.currentCell->cellSouth;
    if(status.compass==west)  status.currentCell = status.currentCell->cellWest;
  }
  
  step = status.currentCell->floodValue;
  int nextStep = step - 1;
    
  Cell *cellMarker = status.currentCell;
    
  neighbor (cellMarker);
    
  if (rightCell->floodValue == nextStep)     motor.rotateRight();
  else if (leftCell->floodValue == nextStep) motor.rotateLeft();
  else if (frontCell->floodValue == nextStep)motor.goStraight(speed);
  
  if (nextStep == 0) /*Changes Mode to return Home?*/ ; //Also, rotate back?
  
}


/*----------------------------------- Speed Run --------------------------------------*/

void Racing::speedRun(int speed)
{  
  /*
  step = status.currentCell->floodValue;
  
  numbStraight = 0;
  nextRight = false;
  nextLeft = false;
  
  while (status.currentCell->goal == false)
  {
    next(status.currentCell); //Decides next movements and updates position within
    
    while ((status.countLeft/countCell) < (numbStraight-1))  //Goes to the cell right before the turn so that it can turn while going straight
      motor.goStraight (speed); //Accelerating Straight Function for Straight-ways Needed      
    if (nextRight)
      motor.turnRight(speed); //Turns Right while going Straight
    else if (nextLeft)
      motor.turnLeft(speed); //Turns Left while going Straight   
  }
  */
}



void Racing::next(Cell *cellMarker)
{
  /*
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
  
  status.currentCell = cellMarker;   
  */
}



/*-----------------------------------------------Sub-Functions-------------------------------------------------*/

void Racing::neighbor(Cell *cellMarker)
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
