final int    TARGET_FPS = 100;
final int    STAR_NBR   = 800;

//Graphics to display
PGraphics    text;

//Array of stars in the screen
Star[] stars = new Star[STAR_NBR];

//Speed of the stars
float speed;
Stopwatch s = new Stopwatch();

void setup() 
{
    fullScreen();
    frameRate(TARGET_FPS);
    
    //Creating all the stars
    for (int i = 0; i < stars.length; i++) 
    {
        stars[i] = new Star();
    }
}

void draw() 
{
    s.start();
    // Setting up speed depending on mouse position
    speed = map(mouseX + 1, 0, width, 0, 50);
    
    //Reset background
    background(0);
  
    // Displaying FPS
    text = createGraphics(150, 60);
    text.noSmooth();
    text.beginDraw();
    text.fill(255);
    text.textSize(10);
    text.textAlign(LEFT, TOP);
    text.loadPixels();
    text.text(nf(frameRate, 2,2) + " FPS ", 0, 0);
    text.endDraw();
    image(text,0,0);
    
    
    // Drawing each star in the screen
    for (int i = 0; i < stars.length; i++) 
    {
        stars[i].update();
        stars[i].show();
    }
    s.stop();
    println("Drawing frame took " + nf(s.getMillis(), 1,5) + "ms");
}
