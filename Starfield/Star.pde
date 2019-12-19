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
        
        //Reset coords
        spx = 0;
        spy = 0;
        sopx = 0;
        sopy = 0;
    }
    
    //Update star position with given coordinates and grayscale color
    void update(double px, double py, double oldPx, double oldPy, int stroke)
    {
        //Save coordinate values
        spx = (float)px;
        spy = (float)py;
        sopx = (float)oldPx;
        sopy = (float)oldPy;
        
        //Draw new line
        pg.stroke(stroke);
        
        //USING LINE
        // pg.line(spx, spy, sopx, sopy);
        
        //USING VERTEX
        pg.beginShape();
        pg.vertex(spx, spy);
        pg.vertex(sopx, sopy);
        pg.endShape();
        
        //USING PShape
        // PShape line = pg.createShape(LINE, spx, spy, sopx, sopy);
        // pg.shape(line);
    }
}
