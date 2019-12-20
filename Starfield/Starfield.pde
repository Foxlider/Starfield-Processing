int    MAX_DEPTH  = 64;
int    STAR_NBR   = 500;
int    TARGET_FPS = 60;
String RENDERER   = JAVA2D; 

double kValue = 450.0;
double halfWidth;
double halfHeight;

Star[] stars;
PGraphics pg;
PGraphics text;

void setup() 
{
    //Display fullscreen
    fullScreen(RENDERER);

    //Create renderer
    pg = createGraphics(width,height, RENDERER);

    //Set anti-aliasing
    pg.smooth();

    //Init starlist
    stars = new Star[STAR_NBR];
    
    //Set target framerate
    frameRate(TARGET_FPS);
    
    //Begin render of frame
    pg.beginDraw();
    pg.background(0);
    //Initialize the stars
    initStars();
    pg.endDraw();
}

void draw() 
{
    //Begin render of frame
    pg.beginDraw();

    //Recalculate screen midpoint
    halfWidth  = width  / 2;
    halfHeight = height / 2;
    
    //Display framerate and "FPS graph"
    //println(nf(frameRate, 2,5) + " > " + new String(new char[(int)frameRate]).replace("\0", " ") + "|");
    text = createGraphics(150, 60);
    text.noSmooth();
    text.beginDraw();
    text.fill(255);
    text.textSize(10);
    text.textAlign(LEFT, TOP);
    text.loadPixels();
    text.text(nf(frameRate, 2,2) + " FPS ", 0, 0);
    text.endDraw();
    
    //Reset screen
    pg.background(0);

    //Iterate through stars
    for( int i = 0; i < STAR_NBR; i++)
    {
        Star star = stars[i];
        
        //Save old Z pos
        double oldZ = star.z;
        //Calculate new Z pos
        star.z -= (512 - kValue) / 100;
        
        //Calculate new front dot position
        Position posVals = CalcPos(star.x, star.y, kValue/star.z);
        
        //If star is out of the screen
        if (star.z <= 0 || (posVals.px <=0 || posVals.px >= width) || (posVals.py <= 0 || posVals.py >= height))
        {
            //Reposition star
            star = new Star(random(-2000.0, 2000.0)/100.0,
                            random(-2000.0, 2000.0)/100.0,
                            random(1, MAX_DEPTH));
            stars[i] = star;
            //Reset old Z pos
            oldZ = star.z;
            //Recalculate position
            posVals = CalcPos(star.x, star.y, kValue/star.z);
        }
        //Calculate old position
        Position oldVals = CalcPos(star.x, star.y, kValue/oldZ);
        
        //Draw star
        star.update(posVals.px, posVals.py, oldVals.px , oldVals.py, (int)((1 - star.z / MAX_DEPTH)*255));
    }
    //End frame render 
    pg.endDraw();

    //Display rendered image
    image(pg,0,0);
    image(text,0,0);
}

void initStars()
{
    //Set screen midpoint
    halfWidth  = width  / 2;
    halfHeight = height / 2;
    
    for( int i = 0; i < STAR_NBR; i++)
    {
        //Create new star
        Star star = new Star(random(-2000.0, 2000.0)/100.0,
                             random(-2000.0, 2000.0)/100.0,
                             random(1, MAX_DEPTH));
        //Add star to starlist
        stars[i] = star;

        //Calculate position
        double k = kValue / star.z;
        double px = star.x * k + halfWidth;
        double py = star.y * k + halfHeight;
        
        //Draw star
        star.update(px, py, px, py, (int)((1 - star.z / MAX_DEPTH)*255));
    }
}

//Calculate coordinates of a dot on a 2D pane with 3D coordinates
Position CalcPos(double origX, double origY, double k)
{
    double px = origX * k + halfWidth;
    double py = origY * k + halfHeight;
    
    return new Position(px, py);
}

//Dot position class
class Position
{
    double px;
    double py;
    
    //CTOR
    Position(double x, double y)
    {
        px = x;
        py = y;
    }
}
