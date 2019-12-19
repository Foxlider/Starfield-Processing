class Star
{
  //Original coordinates
  double x;
  double y;
  double z;
  
  //Saved coordinates
  float spx;
  float spy;
  float sopx;
  float sopy;
  
  //CTOR
  Star(double X, double Y, double Z)
  {
    x = X;
    y = Y;
    z = Z;
    
    //Reset
    spx = 0;
    spy = 0;
    sopx = 0;
    sopy = 0;
  }
  
  void update(double px, double py, double oldPx, double oldPy, int stroke)
  {
    //save coordinate values
    spx = (float)px;
    spy = (float)py;
    sopx = (float)oldPx;
    sopy = (float)oldPy;
    
    //Draw new line
    pg.stroke(stroke);
    pg.line(spx, spy, sopx, sopy);
    
  }
}
