//  GLOBAL SETTINGS
final int    TARGET_FPS = 100;
final int    STAR_NBR   = 800;

//  GRAPHICAL TWEAKS
final String[] RENDERERS = new String[] {P2D, P3D, FX2D, OPENGL};
final String renderer = RENDERERS[0];
final int[] hints= new int[]
{
    //  DEFAULT RENDERER
    ENABLE_STROKE_PURE,
    //  P3D and P2D
    //DISABLE_ASYNC_SAVEFRAME,
    ENABLE_ASYNC_SAVEFRAME,
    DISABLE_OPENGL_ERRORS,
    DISABLE_TEXTURE_MIPMAPS,
    //  P3D only
    //DISABLE_DEPTH_MASK,
    //ENABLE_DEPTH_SORT,
    //DISABLE_DEPTH_TEST,
    //ENABLE_DEPTH_TEST,
    //DISABLE_OPTIMIZED_STROKE,
    //ENABLE_STROKE_PERSPECTIVE
};


//  VARIABLE DECLARATION
//Graphics to display
PGraphics    text;

//Array of stars in the screen
Star[] stars = new Star[STAR_NBR];

//Speed of the stars
float speed;
Stopwatch s = new Stopwatch();

void setup() 
{
    //fullScreen(renderer);
    size(1000,500, renderer);
    noSmooth();
    
    for(int hint : hints)
    {
        println("HINT : " + hint);
        hint(hint);
    }
    
    surface.setResizable(true);
    frameRate(500);
    
    //Creating all the stars
    for (int i = 0; i < stars.length; i++) 
    { stars[i] = new Star(); }
}

void draw() 
{
    // Setting up speed depending on mouse position
    speed = map(mouseX + 1, 0, width, 0, 50);
    
    if(frameRate > TARGET_FPS + 5)
    {
        stars = (Star[])expand(stars, stars.length + 1);
        stars[stars.length - 1] = new Star();
    }
    
    if(frameRate < TARGET_FPS - 2 && stars.length > 100)
    { stars = (Star[])shorten(stars); }
    
    //Reset background
    background(0);
  
    // Displaying FPS
    text = createGraphics(350, 100);
    text.noSmooth();
    text.beginDraw();
    text.fill(255);
    text.textSize(15);
    text.textAlign(LEFT, TOP);
    text.loadPixels();
    text.text(nf(frameRate, 2,2) + " FPS \n"
            + stars.length + " stars\n"
            + width + "x" + height + "\n"
            + "RENDERER : " + renderer, 0, 0);
    text.endDraw();
    image(text,0,0);
        
    // Drawing each star in the screen
    for (int i = 0; i < stars.length; i++) 
    {
        stars[i].update();
        stars[i].show();
    }
}
