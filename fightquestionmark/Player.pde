public class Player{
  Boolean faceRight, onGround;
  BoxCol collider;
  float spawnx;
  float spawny;
  float x;
  float y;
  float xv;
  float yv;
  PImage sprite;
  
  public Player(Boolean isRight, float spawnx, float spawny, PImage sprite){
    this.faceRight = isRight;
    this.onGround = false;
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
    collider.x = x;
    collider.y = y;
    //render player colliders
    //collider.render();
    //floor collision
    if(collider.checkCol(floorCol)){
      yv=0;
      y=floorCol.y-floorCol.ySize/2-12;
      onGround=true;
    }else{
      onGround=false;
    }
    if(x<=0||x>=width){
      x-=xv;
    }
  }
  
  void show(){
    pushMatrix();
    translate(x,y);
    if(!faceRight){
      scale(-1,1);
    }
    image(sprite,0,0,25,25);
    popMatrix();
  }
  
  void getCollider(BoxCol col){
    collider = col;
  }
}
