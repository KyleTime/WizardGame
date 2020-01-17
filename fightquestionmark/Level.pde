public class Level{
  
  public PImage tile;
  
  float tileXSize = 31;
  float tileYSize = 31;
  
  public ArrayList<Platform> platforms;
  
  public Level()
  {
     
  }
  
  void begin()
  {
    tile = loadImage("/Resources/Tiles.png");
    
    platforms = new ArrayList<Platform>() {};
  }
  
  void update()
  {
    checkCollider();
    
    updatePlatforms();
  }
  
  void checkCollider()
  {
    if(platforms.size() != 0)
    {
      for(Platform pl:platforms)
      {
        if(pl.collider == null)
        {
          pl.collider = new BoxCol(0,0,0,0);
          pl.updateCollider();
        }
      }
    }
  }
  
  void createPlatformsBlock(int x, int y, int xSize, int ySize)
  {
    for(int x1 = 0; j < xSize; j++)
    {
      for(int y1 = 0; )
    }
  }
  
  void updatePlatforms()
  {
    for(Platform pl:platforms)
    {
      pl.update();
    }
  }
  
  public float[] getGrid(int x, int y)
  {
    return new float[] {x*tileXSize, y*tileYSize};
  }
}
