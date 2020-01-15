public class CirCol{

  float x;
  float y;
  float rad;
  
  public CirCol(float x, float y, float rad)
  {
    this.x = x;
    this.y = y;
    this.rad = rad;
  }

  boolean checkCol(CirCol c)
  {
     if(dis(x,y,c.x,c.y) <= rad/2 + c.rad/2)
     {
         return true;
     }
     else
       return false;
  }
  
  boolean checkCol(BoxCol b)
  {
    float[] least = new float[2];
    
    float slopeX = x - b.x;
    float slopeY = y - b.y;
   
    
    float slope = slopeY/slopeX;
    
    
    float unit = atan(slope);
    
    least[0] = x - cos(unit)*rad/2;
    least[1] = y - sin(unit)*rad/2;
    
    //render line code
    /*
    stroke(0,0,0);
    line(least[0], least[1], x,y);
    stroke(255,0,0);
    point(least[0], least[1]);
    stroke(0,0,0);
    */
    
    
     if(abs(least[0] - b.x) <= b.xSize/2 && abs(least[1] - b.y) <= b.ySize/2)
     {
         return true;
     }
     else
       return false;
  }
  
  void render()
  {
      circle(x,y,rad);
      point(x,y);
  }

}

public class BoxCol{

  float x;
  float y;
  
  float xSize;
  float ySize;

  public BoxCol(float x, float y, float xSize, float ySize)
  {
    this.x = x;
    this.y = y;
    this.xSize = xSize;
    this.ySize = ySize;
  }
  
  boolean checkCol(CirCol c)
  {
    float[] least = new float[2];
    
    float slopeX = x - c.x;
    float slopeY = y - c.y;
   
    
    float slope = slopeY/slopeX;
    
    
    float unit = atan(slope);
    
    least[0] = c.x + cos(unit)*c.rad/2;
    least[1] = c.y + sin(unit)*c.rad/2;
    
    //render line code
    /*
    stroke(0,0,0);
    line(least[0], least[1], c.x,c.y);
    stroke(255,0,0);
    point(least[0], least[1]);
    stroke(0,0,0);
    */
    
    
    
     if(abs(least[0] - x) <= xSize/2 && abs(least[1] - y) <= ySize/2)
     {
         return true;
     }
     else
       return false;
  }
  
  boolean checkCol(BoxCol b)
  {
    if(abs(x - b.x) <= b.xSize/2 + xSize/2 && abs(y - b.y) <= b.ySize/2 + ySize/2)
    {
      return true;
    }
    else
      return false;
  }
  
  
  
  void render()
  {
    rect(x - xSize/2, y - ySize/2, xSize, ySize);
    point(x,y);
  }
}


float dis(float x1, float y1, float x2, float y2)
{
    return sqrt( pow(x1 - x2,2) + pow(y1 - y2,2));
}
