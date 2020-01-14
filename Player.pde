public class Player{
  Boolean faceRight;
  float spawnx;
  float spawny;
  float x;
  float y;
  float xv;
  float yv;
  PImage sprite;
  
  public Player(Boolean isRight, float spawnx, float spawny, PImage sprite){
    this.faceRight = isRight;
    this.spawnx = spawnx;
    this.spawny = spawny;
    this.x = spawnx;
    this.y = spawny;
    this.sprite = sprite;
  }
  
  void spawn(){
    x = spawnx;
    y = spawny;
  }
}
