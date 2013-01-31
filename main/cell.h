#ifndef CELL_H
#define CELL_H

class CELL{
public:
  CELL();
  bool visit;
  bool wall[4];
  bool goal;
  int floodValue;
}


#endif
