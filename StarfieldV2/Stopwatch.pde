class Stopwatch {
    private long startTime;
    private long stopTime;

    public void start() 
    { 
        startTime = System.nanoTime();
        stopTime = startTime;
    }

    public void stop() 
    { stopTime = System.nanoTime(); }

    public long getNanos() 
    { return stopTime - startTime; }
  
    public float getMillis()
    { return getNanos()/1000000.000000; }
}
