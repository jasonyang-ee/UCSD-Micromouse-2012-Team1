
#include "maze.h"

/*===================  public functions  =======================*/
void Maze::mapping()
{  
  bool nextdead = false;                                                      //Used when reach a dead end, sets mode so when going back to intersection, sets cell behind it to dead. 
  int speed = mappingSpeed;
  while(cell[status.y][status.x].goal == false)                               //When current cell is not the goal. 
  {
    status.wheelCountLeft = 0;                                               //Resets Encoders to Zero
    status.wheelCountRight = 0;
    
    if (status.sideLeftDist < wallExistDist && status.sideRightDist < wallExistDist       //Case 1, Two walls Left Right Side. Forward Open
        && status.frontLeftDist > wallExistDist && status.frontRightDist > wallExistDist)
    {
      while(status.sideLeftDist < wallExistDist && status.sideRightDist < wallExistDist 
          && status.frontLeftDist > wallExistDist && status.frontRightDist > wallExistDist)
      {
      motor.goStraight(speed);
      }
      motor.stop;
      //taking the wheel count average
      int wheelCount = (status.wheelCountLeft + status.wheelCountRight)/2;
      
      
      //set wall if haven't yet
      if (cell[status.y][status.x].visit == false)
      {
        if (directx == 0)                                //Adds wall for current cell it is in.
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
       else
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        
        for(int i=1; i<(wheelCount/cellLength); i++) //This does not include the current cell it is in, only the ones it drove through.
        {
          status.x += directx;
          status.y += directy;
          
          if (directx == 0)
          {
            cell[status.y][status.x].wall[0]=false;
            cell[status.y][status.x].wall[1]=true;
            cell[status.y][status.x].wall[2]=false;
            cell[status.y][status.x].wall[3]=true;      
            cell[status.y][status.x].visit = true;
          }
          else
          {
            cell[status.y][status.x].wall[0]=true;
            cell[status.y][status.x].wall[1]=false;
            cell[status.y][status.x].wall[2]=true;
            cell[status.y][status.x].wall[3]=false;      
            cell[status.y][status.x].visit = true;
          }
        }
      }
      status.x += directx; //sets position to current cell. 
      status.y += directy;
    }
    
    if (status.sideLeftDist > wallExistDist && status.sideRightDist < wallExistDist                   //Case 2, Wall Exists in Front and Right, Left Open
        && status.frontLeftDist < wallExistDist && status.frontRightDist < wallExistDist)
    {
      motor.turnLeft (speed);
      
      
      if (cell[status.y][status.x].visit == false)
      {
        if (directy == 1)                                        //Inefficient way to account for all mouse directions.
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else if (directy == -1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
        else if (directx == 1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else //directx == -1
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
      }
    
      if (directx == 0)          //Changes direction
      {
        directx = -1*directy;
        directy = 0;
      }
      else
      {
        directy = directx;
        directx = 0;
      }
      
      motor.goStraightOne (speed); //Goes to Next cell
     
      status.x += directx;
      status.y += directy;
      
    }
    
    if (status.sideLeftDist < wallExistDist && status.sideRightDist > wallExistDist                   //Case 3, Wall Exists in Front and Left, Right Open
        && status.frontLeftDist < wallExistDist && status.frontRightDist < wallExistDist)
    {
      motor.turnRight (speed);
      
      if (cell[status.y][status.x].visit == false)
      {
        if (directy == 1)                                        //Inefficient way to account for all mouse directions.
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
        else if (directy == -1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else if (directx == 1)
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else //directx = -1
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
      }
        
      if (directx == 0)          //Changes direction-Turn Right
      {
        directx = directy;
        directy = 0;
      }
      else
      {
        directy = -1*directx;
        directx = 0;
      }
      
      
      motor.goStraightOne (speed);
      
      status.x += directx;
      status.y += directy;
    }
    
    if (status.sideLeftDist < wallExistDist && status.sideRightDist < wallExistDist                   //Case 4, Wall Exists On All Sides (except Behind)
        && status.frontLeftDist < wallExistDist && status.frontRightDist < wallExistDist)
    {
      motor.turnBack;
      
      if (cell[status.y][status.x].visit == false)
      {
        if (directy == 1)                                        //Inefficient way to account for all mouse directions.
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
        else if (directy == -1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
        else if (directx == 1)
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else //directx == -1
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
      }
    
      if (directx == 0)          //Changes direction-Turn Back
        directy *= -1;
      else
        directx *= -1;
      
      motor.goStraightOne (speed);
      
      status.x += directx;
      status.y += directy;
      
      nextdead = true;        //When going back, next intersection it reaches will make it put cell behind it to dead. 
      
    }
    if (status.sideLeftDist > wallExistDist && status.sideRightDist > wallExistDist                   //Case 5, Wall Exists in Front, open Rest
        && status.frontLeftDist < wallExistDist && status.frontRightDist < wallExistDist)
    {
      
      //Maps out Walls Based on Direction if not visited
      
      if (cell[status.y][status.x].visit == false)
      {
        if (directy == 1)                                        //Inefficient way to account for all mouse directions.
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else if (directy == -1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else if (directx == 1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else //directx == -1
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
      }
      
      
      //////////////Determines Next Action based on various things (default is to turn Right) and Changes Direction
      if (nextdead = true)
      { 
        cell[status.y - directy][status.x - directx].dead = true; //behind cell is dead 
        nextdead = false;
      }
      
      if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directx][status.x - directy].dead = true)  //If Left and Right are Dead
      {
        motor.turnBack;
        nextdead = true;
        if (directx == 0)          //Changes direction-Turn Back
          directy *= -1;
        else
          directx *= -1;
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directx][status.x - directy].dead = false) //If only Right Dead
      {
        motor.turnLeft (speed);
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        if (directx == 0)                 //Changes direction-Turn Left
        {
          directx = -1*directy;
          directy = 0;
        }
        else
        {
          directy = directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = false && cell[status.y + directx][status.x - directy].dead = true) //If only Left Dead
      {
        motor.turnRight (speed);
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = true) //If Visited Both, turn Right (choice)
      {
        motor.turnRight (speed);
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = false) //If Visited Right, turn Left
      {
        motor.turnLeft (speed);
        if (directx == 0)               //Changes direction turn Left
        {
          directx = -1*directy;
          directy = 0;
        }
        else
        {
          directy = directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = false  && cell[status.y + directx][status.x - directy].visit = true) //If Visited Left, turn Right
      {
        motor.turnRight (speed);
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
      
      else                                                                                                                              //If Both Unknown, turn Right (choice)
      {
        motor.turnRight (speed);
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
       //////////////////Decision Making Ends
       
       motor.goStraightOne (speed);
       
       status.x += directx;
       status.y += directy;
    }
    
    if (status.sideLeftDist > wallExistDist && status.sideRightDist < wallExistDist                                 //Case 6, Wall Exists Right Only, Rest Open
        && status.frontLeftDist > wallExistDist && status.frontRightDist > wallExistDist)
    {
     //Maps out Walls Based on Direction if not visited
      
      if (cell[status.y][status.x].visit == false)
      {
        if (directy == 1)                                        //Inefficient way to account for all mouse directions.
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else if (directy == -1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
        else if (directx == 1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else //directx == -1
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
      }
      
      //////////////Determines Next Action based on various things (default is to go Forward) and Changes Direction
      if (nextdead = true)
      { 
        cell[status.y - directy][status.x - directx].dead = true; //behind cell is dead 
        nextdead = false;
      }
      
      if (cell[status.y + directy][status.x + directx].dead = true && cell[status.y + directx][status.x - directy].dead = true)  //If Left and Forward are Dead
      {
        motor.turnBack;
        nextdead = true;
        if (directx == 0)          //Changes direction-Turn Back
          directy *= -1;
        else
          directx *= -1;
      }
      
      else if (cell[status.y + directy][status.x + directx].dead = true && cell[status.y + directx][status.x - directy].dead = false) //If only Forward Dead
      {
        motor.turnLeft (speed);
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        if (directx == 0)                 //Changes direction-Turn Left
        {
          directx = -1*directy;
          directy = 0;
        }
        else
        {
          directy = directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y + directy][status.x + directx].dead = false && cell[status.y + directx][status.x - directy].dead = true) //If only Left Dead
      {
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        
        //No Direction Change needed, will go forward
      }
      
      else if (cell[status.y + directy][status.x + directx].visit = true && cell[status.y + directx][status.x - directy].visit = true) //If Visited Both, go Forward (choice)
      {
        //No Direction Change Needed, will go Forward
      }
      
      else if (cell[status.y + directy][status.x + directx].visit = true && cell[status.y + directx][status.x - directy].visit = false) //If Visited Forward Only, turn Left
      {
        motor.turnLeft (speed);
        if (directx == 0)               //Changes direction turn Left
        {
          directx = -1*directy;
          directy = 0;
        }
        else
        {
          directy = directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y + directy][status.x + directx].visit = false  && cell[status.y + directx][status.x - directy].visit = true) //If Visited Left Only, go Forward
      {
        //No Direction Change Needed, will go Forward
      }
      
      else                                                                                                                              //If Both Unknown, Go Forward (Choice)
      {
        //No Direction Change Neeeded, will go Forward
      }
       //////////////////Decision Making Ends
       
       motor.goStraightOne (speed);
       
       status.x += directx;
       status.y += directy;
    }
    
    if (status.sideLeftDist < wallExistDist && status.sideRightDist > wallExistDist                                 //Case 7, Wall Exists Left Only, Rest Open
        && status.frontLeftDist > wallExistDist && status.frontRightDist > wallExistDist)
    {
      //Maps out Walls Based on Direction if not visited
      
      if (cell[status.y][status.x].visit == false)
      {
        if (directy == 1)                                        //Inefficient way to account for all mouse directions.
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=true;      
          cell[status.y][status.x].visit = true;
        }
        else if (directy == -1)
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=true;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else if (directx == 1)
        {
          cell[status.y][status.x].wall[0]=true;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
        else //directx == -1
        {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=true;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
        }
      }
      
      //////////////Determines Next Action based on various things (default is to Go Forward) and Changes Direction
      if (nextdead = true)
      { 
        cell[status.y - directy][status.x - directx].dead = true; //behind cell is dead 
        nextdead = false;
      }
      
      if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directy][status.x + directx].dead = true)  //If Left and Forward are Dead
      {
        motor.turnBack;
        nextdead = true;
        if (directx == 0)          //Changes direction-Turn Back
          directy *= -1;
        else
          directx *= -1;
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directy][status.x + directx].dead = false) //If only Right Dead
      {
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        //No Direction Change Needed, will go Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = false && cell[status.y + directy][status.x + directx].dead = true) //If only Forward Dead
      {
        motor.turnRight (speed);
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directy][status.x + directx].visit = true) //If Visited Both, go Forward (choice)
      {
        //No Direciton Change Needed, will go Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directy][status.x + directx].visit = false) //If Visited Right, go Forward (choice)
      {
        //No Direction Change Needed, will go Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = false  && cell[status.y + directy][status.x + directx].visit = true) //If Visited Forward, turn Right
      {
        motor.turnRight (speed);
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
      
      else                                                                                                                              //If Both Unknown, go Forward (choice)
      {
        //No Direction Change Needed, will go Forward
      }
       //////////////////Decision Making Ends
      
      motor.goStraightOne (speed);
      
      status.x += directx;
      status.y += directy;
                  
    }
    
    if (status.sideLeftDist > wallExistDist && status.sideRightDist > wallExistDist                                 //Case 8, No Walls, Special Case
        && status.frontLeftDist > wallExistDist && status.frontRightDist > wallExistDist)
    {
      if (cell[status.y][status.x].visit == false)       //No Walls for Any Direction
      {
          cell[status.y][status.x].wall[0]=false;
          cell[status.y][status.x].wall[1]=false;
          cell[status.y][status.x].wall[2]=false;
          cell[status.y][status.x].wall[3]=false;      
          cell[status.y][status.x].visit = true;
      }
      
      //////////////Determines Next Action based on various things (default is to go Forward) and Changes Direction 
      if (nextdead = true)
      { 
        cell[status.y - directy][status.x - directx].dead = true; //behind cell is dead 
        nextdead = false;
      }
      
      if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directx][status.x - directy].dead = true 
                                                                          && cell[status.y + directy][status.x + directx].dead = true)      //If all Three Are Dead  
      {
        motor.turnBack;
        nextdead = true;
        if (directx == 0)          //Changes direction-Turn Back
          directy *= -1;
        else
          directx *= -1;
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directx][status.x - directy].dead = true
                                                                          && cell[status.y + directy][status.x + directx].dead = false) //If Right and Left Dead, go Forward
      {
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        
        //Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directx][status.x - directy].dead = false
                                                                          && cell[status.y + directy][status.x + directx].dead = true) //If Right and Forward Dead, Go Left
      {
        motor.turnLeft (speed);
        
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
          
        if (directx == 0)               //Changes direction turn Left
        {
          directx = -1*directy;
          directy = 0;
        }
        else
        {
          directy = directx;
          directx = 0;
        }
        
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = false && cell[status.y + directx][status.x - directy].dead = true
                                                                          && cell[status.y + directy][status.x + directx].dead = true) //If Left and Forward Dead, Go Right
      {
        motor.turnRight (speed);
        if (cell[status.y - directy][status.x - directx].dead = true)                                           //If behind also dead, will kill this path at next intersection
          nextdead = true;
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
        
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = false && cell[status.y + directx][status.x - directy].dead = true
                                                                          && cell[status.y + directy][status.x + directx].dead = false) //If Left Dead only
      {
          if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directy][status.x + directx].visit = true) //If Visited Both, go Forward (choice)
          {
            //No Direciton Change Needed, will go Forward
          }
          
          else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directy][status.x + directx].visit = false) //If Visited Right, go Forward (choice)
          {
            //No Direction Change Needed, will go Forward
          }
          
          else if (cell[status.y - directx][status.x + directy].visit = false  && cell[status.y + directy][status.x + directx].visit = true) //If Visited Forward, turn Right
          {
            motor.turnRight (speed);
            if (directx == 0)          //Changes direction-Turn Right
            {
              directx = directy;
              directy = 0;
            }
            else
            {
              directy = -1*directx;
              directx = 0;
            }
          }
          
          else                                                                                                                              //If Both Unknown, go Forward (choice)
          {
            //No Direction Change Needed, will go Forward
          }
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = true && cell[status.y + directx][status.x - directy].dead = false
                                                                          && cell[status.y + directy][status.x + directx].dead = false) //If Right Dead only
      {
            if (cell[status.y + directy][status.x + directx].visit = true && cell[status.y + directx][status.x - directy].visit = true) //If Visited Both, go Forward (choice)
            {
              //No Direction Change Needed, will go Forward
            }
            
            else if (cell[status.y + directy][status.x + directx].visit = true && cell[status.y + directx][status.x - directy].visit = false) //If Visited Forward Only, turn Left
            {
              motor.turnLeft (speed);
              if (directx == 0)               //Changes direction turn Left
              {
                directx = -1*directy;
                directy = 0;
              }
              else
              {
                directy = directx;
                directx = 0;
              }
            }
            
            else if (cell[status.y + directy][status.x + directx].visit = false  && cell[status.y + directx][status.x - directy].visit = true) //If Visited Left Only, go Forward
            {
              //No Direction Change Needed, will go Forward
            }
            
            else                                                                                                                              //If Both Unknown, Go Forward (Choice)
            {
              //No Direction Change Neeeded, will go Forward
            } 
      }
      
      else if (cell[status.y - directx][status.x + directy].dead = false && cell[status.y + directx][status.x - directy].dead = true
                                                                          && cell[status.y + directy][status.x + directx].dead = false) //If Forward Dead only
      {
          if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = true) //If Visited Both, turn Right (choice)
          {
            motor.turnRight (speed);
            if (directx == 0)          //Changes direction-Turn Right
            {
              directx = directy;
              directy = 0;
            }
            else
            {
              directy = -1*directx;
              directx = 0;
            }
          }
          
          else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = false) //If Visited Right, turn Left
          {
            motor.turnLeft (speed);
            if (directx == 0)               //Changes direction turn Left
            {
              directx = -1*directy;
              directy = 0;
            }
            else
            {
              directy = directx;
              directx = 0;
            }
          }
          
          else if (cell[status.y - directx][status.x + directy].visit = false  && cell[status.y + directx][status.x - directy].visit = true) //If Visited Left, turn Right
          {
            motor.turnRight (speed);
            if (directx == 0)          //Changes direction-Turn Right
            {
              directx = directy;
              directy = 0;
            }
            else
            {
              directy = -1*directx;
              directx = 0;
            }
          }
          
          else                                                                                                                              //If Both Unknown, turn Right (choice)
          {
            motor.turnRight (speed);
            if (directx == 0)          //Changes direction-Turn Right
            {
              directx = directy;
              directy = 0;
            }
            else
            {
              directy = -1*directx;
              directx = 0;
            }
          }
      }
      
      ///////////////////If None Dead, More Decision Making/////////////////////
      
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = true
                                                                          && cell[status.y + directy][status.x + directx].visit = true)) //If Visited All Three, go Forward
      {
            //Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = true
                                                                          && cell[status.y + directy][status.x + directx].visit = false)) //If Visited Right and Left, go Forward
      {
        //Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = false
                                                                          && cell[status.y + directy][status.x + directx].visit = true)) //If Visited Right and Forward, go Left
      {
        motor.turnLeft (speed);
        if (directx == 0)               //Changes direction turn Left
        {
          directx = -1*directy;
          directy = 0;
        }
        else
        {
          directy = directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = false && cell[status.y + directx][status.x - directy].visit = true
                                                                          && cell[status.y + directy][status.x + directx].visit = true)) //If Visited Left and Forward, go Right
      {
        motor.turnRight (speed);
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = true && cell[status.y + directx][status.x - directy].visit = false
                                                                          && cell[status.y + directy][status.x + directx].visit = false)) //If Visited Right Only, go Forward
      {
        //Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = false && cell[status.y + directx][status.x - directy].visit = true
                                                                          && cell[status.y + directy][status.x + directx].visit = false)) //If Visited Left Only, go Forward
      {
        //Forward
      }
      
      else if (cell[status.y - directx][status.x + directy].visit = false && cell[status.y + directx][status.x - directy].visit = false
                                                                          && cell[status.y + directy][status.x + directx].visit = true)) //If Visited Forward Only, go Right (choice)
      {
        motor.turnRight (speed);
        if (directx == 0)          //Changes direction-Turn Right
        {
          directx = directy;
          directy = 0;
        }
        else
        {
          directy = -1*directx;
          directx = 0;
        }
      }
      
      else                                                                                                                              //If All Unknown, go Forward (choice)
      {
        //Forward
      }     
            
       //////////////////Decision Making Ends
             
      motor.goStraightOne (speed);
      
      status.x += directx;
      status.y += directy;      
    }
    
    //All 8 Special Cases have been Specified. Continues While Loop until in Goal Cell.     
      
  } //Closes While loop
  
  //set wall info for the 4 goal cells
  //then stop and turn back and map other place base on cell visit value
  //then go back to start cell[0][0]
 
}

void Maze::floodFill() //Floodfill Function, Which will determine the fastest route to goal from start. This is executed after mapping is adequate/'button' is pressed.
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
      cell[y][x].dead = false;
    } 
  
  //assign goal to 4 cells
  cell[mazeSize/2-1][mazeSize/2-1].goal = true; //Goal in [7,7][7,8][8,7][8,8]
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
    
  cell[0][0].wall[0] = false;
  cell[0][0].visit = true;
    
  //initialize emptyCell
  emptyCell.x = -1;
  emptyCell.y = -1;
  emptyCell.visit = false;
  for(int i=0; i<4; i++) emptyCell.wall[i] = false;
  emptyCell.goal = false;
  emptyCell.existance = false;
  
  status.y = 0; //Set y and x to starting cell. Will be used to determine current location of mouse. 
  status.x = 0;
  
  directy = 1; //Facing North
  directx = 0; //Vertical
}


/*===================  debug functions  =======================*/

void Maze::printAll()
{
//print all status variable for debug 
}


