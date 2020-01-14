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
    float closest = 1000000;
    for(float x = 0; x < 360; x++)
    {
      float radian = map(x,0,360,0,2*PI);
      float newX = x + cos(radian)*rad;
      float newY = y + sin(radian)*rad;
        
       if(dis(newX,newY, b.x,b.y) < closest)
       {
          least[0] = newX;
          least[1] = newY;
       }
    }
    
    
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
