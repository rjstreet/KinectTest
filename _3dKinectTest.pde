import objimp.*;
import utils.*;
import com.obj.parser.mtl.*;
import com.obj.parser.obj.*;
import com.obj.parser.*;
import com.obj.*;

import SimpleOpenNI.*;
import processing.opengl.*;

HeavyBag heavy_bag;
SimpleOpenNI kinect;
float rotation = 0;
int boxSize = 150;
int hitThreshold = 25;
float s = 1;
OtherView other_view;
boolean drawAgain=false;
Timer timer;
float currentDelay;
int[] userMap;
 
void setup() 
{
  size(640, 480, OPENGL);
  other_view = new OtherView();
  MainFrame frame = new MainFrame( other_view );
  heavy_bag = new HeavyBag( this );
  kinect = new SimpleOpenNI( this );
  kinect.enableDepth();
  timer = new Timer();
}

void draw() 
{
  int depthPointsInBox = 0;
  background(129);
  lights();
  kinect.update();
  
  translate( width/2, height/2, -1000 );
  rotateX( radians( 180 ) );
  translate( 0, 0, 1000 );
  rotateY( radians( map(mouseX, 0, width, -180, 180 ) ) );
  translate( 0, 0, s *-1000 );
  scale( s );
  stroke( 255 );
  userMap = kinect.getUsersPixels( SimpleOpenNI.USERS_ALL );
  PVector[] depthPoints = kinect.depthMapRealWorld();
  for( int i = 0; i < depthPoints.length; i+= 10 )
  {
    PVector currentPoint = depthPoints[i];
    
    if( heavy_bag.check( currentPoint ) )
        depthPointsInBox++;
    this.point( depthPoints[i].x, depthPoints[i].y, depthPoints[i].z );
  }
  heavy_bag.setDrawToHit( timer.timePassed() );
  heavy_bag.draw( depthPointsInBox > hitThreshold );
  if( timer.timePassed() && depthPointsInBox > hitThreshold )
  {
    currentDelay = millis() - timer.next_time;
    timer.reset();
  }
  other_view.image( get(), 0, 0 );
  other_view.fill( 255, 0, 0 );  
  other_view.text( "Time to strike: " + ((float)currentDelay)/1000.0 + "s", 0, 0, 640, 200 );
}

void keyPressed() 
{
  if( keyCode == 38 )
    s=s+0.01;
  if( keyCode == 40 )
    s=s-0.01;
}


