import SimpleOpenNI.*;
import processing.opengl.*;
import saito.objloader.*;

class HeavyBag
{
  OBJModel model;
  int boxSize = 150;
  int maxPoints = 150;
  PVector boxCenter = new PVector( 0, 0, 1600 );
  boolean drawToHit=false;
  int s_factor = 800;
  BoundingBox bbox;
  
  HeavyBag(PApplet parent) 
  {
    model = new OBJModel( parent, dataPath("ufc.obj"), "relative", TRIANGLES );
    model.translateToCenter();
    model.enableTexture();
    model.enableMaterial();
    model.setupGL();
    bbox = new BoundingBox(parent, model);
    println( bbox.getWHD());
  }
  
  boolean check(PVector currentPoint)
  {
    return currentPoint.x > boxCenter.x - bbox.getWHD().x * s_factor / 2 && currentPoint.x < boxCenter.x + bbox.getWHD().x * s_factor / 2
      && currentPoint.y > boxCenter.y - bbox.getWHD().y * s_factor / 2 && currentPoint.y < boxCenter.y + bbox.getWHD().y * s_factor / 2
      && currentPoint.z > boxCenter.z - bbox.getWHD().z * s_factor / 2 && currentPoint.z < boxCenter.z + bbox.getWHD().z * s_factor / 2;
  }
  
  void setDrawToHit( boolean val )
  {
    drawToHit = val;
  }
  
  void draw(boolean drawWithHit)
  {
    pushMatrix();
    translate( boxCenter.x, boxCenter.y, boxCenter.z );
    scale(s_factor);
    rotateZ( radians( 180 ) );
    if( drawWithHit )
    {
      float boxAlpha = map( 200, 0, 1000, 0, 255 );
      pushMatrix();
      translate( boxCenter.x, boxCenter.y, boxCenter.z );
      fill( 255, 0, 0, boxAlpha );
      stroke( 255, 0, 0 );
      box( boxSize );
      popMatrix();
      setDrawToHit( false );
    }
   else if( drawToHit )
    {
      float boxAlpha = map( 200, 0, 1000, 0, 255 );
      pushMatrix();
      translate( boxCenter.x, boxCenter.y, boxCenter.z );
      fill( 0, 0, 255, boxAlpha );
      stroke( 0, 255, 0 );
      box( boxSize );
      popMatrix();
    }
    else
      noStroke();
    model.drawGL();
    popMatrix();    
  }
}
