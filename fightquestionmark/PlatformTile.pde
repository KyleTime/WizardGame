public class Platform{
  int gridX;
  int gridY;
  
  Level l;
  
  BoxCol collider;
  
  public Platform(int gridX, int gridY, Level l)
  {
    this.gridX = gridX;
    this.gridY = gridY;
    this.l = l;
    if(collider != null)
      updateCollider();
  }
  
  void update()
  {
    render();
  }
  
  void getCollider(BoxCol b)
  {
    this.collider = b;
  }
  
  void updateCollider()
  {
    float[] pos = l.getGrid(gridX, gridY);
    collider.x = pos[0];
    collider.y = pos[1];
    collider.xSize = l.tileXSize;
    collider.ySize = l.tileYSize;
  }
  
  void render()
  {
    float[] pos = l.getGrid(gridX, gridY);
    
    image(l.tile, pos[0], pos[1]);
    println(pos[0]+" "+pos[1]+";");
  }

}
