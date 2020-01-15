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
  Player other;
  
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
    //wall collision
    if(x<=0+12||x>=width-12){
      x-=xv;
    }
    //player collision
    if(collider.checkCol(other.collider)){
      if(y<=other.y-other.collider.ySize/2){
        yv = other.yv;
        xv = other.xv;
        y = other.y-other.collider.ySize;
        onGround = true;
      }else if(x<=other.x-other.collider.xSize/2||x>=other.x+other.collider.xSize/2){
        x-=xv/2;
        other.x+=xv/2;
      }else{
        yv-=0.1;
        onGround=true;
      }
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
  
  void getOtherPlayer(Player p){
    other = p;
  }
}
