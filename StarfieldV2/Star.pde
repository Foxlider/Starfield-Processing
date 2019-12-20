//Star class representing a star being drawn
class Star 
{
    // X and Y position of the star in the screen
    float x;
    float y;
    // Z position of the star corresponding to its depth in the 3D environment, 
    // used to calculate its position each frame
    float z;
  
    // Saving 'z' value of the previous frame 
    float pz;
  
    Star() 
    {
        //Generating a new star at random coordinates
        x = random(-width/2, width/2);
        y = random(-height/2, height/2);
        z = random(width/2);
        
        pz = z;
    }

  void update() 
  {
      //Update the depth ('z') of the star
      z = z - speed;
      
      // If 'z' is 0 or lower, reset the star to a new position because it left the screen.
      if (z <=0) 
      {
          z = width/2;
          x = random(-width/2, width/2);
          y = random(-height/2, height/2);
          pz = z;
      }
  }

  void show() 
  {
      //calculate star coordinates
      float sx = map(x, 0, z, 0, width/2) + width/2;
      float sy = map(y, 0, z, 0, height/2) + height/2;;
  
      //Calculate tail end coordinates
      float px = map(x, 0, pz, 0, width/2) + width/2;
      float py = map(y, 0, pz, 0, height/2) + height/2;
  
      // Make sure that 'pz' is always equals
      // to the 'z' value of the previous frame.
      pz = z;
  
      //Get the color of the star depending on its 'z' value
      stroke(map(pz, 0, width/2, 255, 0));
      line(px, py, sx, sy);
  }
}
