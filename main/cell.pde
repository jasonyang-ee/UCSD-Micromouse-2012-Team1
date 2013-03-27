/*=================  Direction code  =====================

    N          0
  W   E  ==  3   1
    S          2

/*=======================================================*/

#include "cell.h"

void Cell::setCurrent()
{
  status.currentCell = *this;
}

Cell Cell::operator++(int)
{
  Cell temp
  switch(status.compass)
  {
    case 0:
      temp = cell[*this->y+1][*this->x];
  }
  return temp;
}
