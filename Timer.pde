class Timer
{
  float last_time;
  float next_time;
  
  Timer()
  {
    generateNextDelay();
  }
  
  void generateNextDelay()
  {
    last_time = millis();
    next_time = last_time + random( 1000,5000 );
  }
  
  boolean timePassed()
  {
    return ( next_time < millis() );
  }
  
  void reset()
  {
    last_time = millis();
    generateNextDelay();
  }
}
