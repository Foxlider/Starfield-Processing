int    MAX_DEPTH  = 128;
int    STAR_NBR   = 500;
int    TARGET_FPS = 75;
String RENDERER   = JAVA2D; 

double kValue = 500.0;
double halfWidth;
double halfHeight;

Star[] stars;
PGraphics pg;

void setup() 
{
  fullScreen(RENDERER);
  //size(800, 600);
  pg = createGraphics(width,height, RENDERER);
  //pg.smooth();
  surface.setResizable(true);
  stars = new Star[STAR_NBR];
  frameRate(TARGET_FPS);
  pg.beginDraw();
  pg.background(0);
  initStars();
  pg.endDraw();
}

void draw() 
{
  pg.beginDraw();
  halfWidth  = width  / 2;
  halfHeight = height / 2;
  
  println(nf(frameRate, 3,5) + " > " + new String(new char[(int)frameRate]).replace("\0", " ") + "|");
  
  pg.background(0);
  for( int i = 0; i < STAR_NBR; i++)
  {
    Star star = stars[i];
    if(star == null)
    {
      println(">WARNING< star " + i + " not found");
      continue;
    }
    
    double oldZ = star.z;
    star.z -= (512 - kValue) / 100;
    
    Position posVals = CalcPos(star.x, star.y, kValue/star.z);
    
    if (star.z <= 0 || (posVals.px <=0 || posVals.px >= width) || (posVals.py <= 0 || posVals.py >= height))
    {
      star = new Star(random(-2000, 2000)/100,
                        random(-2000, 2000)/100,
                        random(1, MAX_DEPTH));
      stars[i] = star;
      oldZ = star.z;
      posVals = CalcPos(star.x, star.y, kValue/star.z);
    }
    
    Position oldVals = CalcPos(star.x, star.y, kValue/oldZ);
    
    star.update(posVals.px, posVals.py, oldVals.px , oldVals.py, (int)((1 - star.z / MAX_DEPTH)*255));
  }
  pg.endDraw();
  image(pg,0,0);
  
  //filter( BLUR, 1 );
}

void initStars()
{
  halfWidth  = width  / 2;
  halfHeight = height / 2;
  
  for( int i = 0; i < STAR_NBR; i++)
  {
    Star star = new Star(random(-2000, 2000)/100,
                         random(-2000, 2000)/100,
                         random(1, MAX_DEPTH));
    stars[i] = star;
    double k = kValue / star.z;
    double px = star.x * k + halfWidth;
    double py = star.y * k + halfHeight;
    
    star.update(px, py, px, py, (int)((1 - star.z / MAX_DEPTH)*255));
  }
}

Position CalcPos(double origX, double origY, double k)
{
    double px = origX * k + halfWidth;
    double py = origY * k + halfHeight;

    return new Position(px, py);
}

class Position
{
  double px;
  double py;
  
  Position(double x, double y)
  {
    px = x;
    py = y;
  }
}
