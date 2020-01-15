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
  
  void update(){
    yv+=0.3;
    xv*=0.9;
    y+=yv;
    x+=xv;
    if(y>floorHeight-28){
      y=floorHeight-28;
      yv=0;
    }
  }
  
  void show(){
    translate(x,y);
    image(sprite,0,0,100,100);
  }
}
