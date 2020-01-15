public class Player{
  Boolean faceRight, onGround;
  BoxCol collider;
  float spawnx, spawny, x, y, xv, yv, radian;
  PImage sprite;
  Player other;
  ArrayList<Hat> hatList;
  
  public Player(Boolean isRight, float spawnx, float spawny, PImage sprite, ArrayList<Hat> h){
    this.faceRight = isRight;
    this.onGround = false;
    this.spawnx = spawnx;
    this.spawny = spawny;
    this.x = spawnx;
    this.y = spawny;
    this.sprite = sprite;
    this.radian = 0;
    this.hatList = h;
  }
  
  void spawn(){
    x = spawnx;
    y = spawny;
  }
  
  void update(){
    yv+=0.3;
    if(onGround){
      xv*=0.9;
    }else{
      xv*=0.99;
    }
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
      }
    }
    //hat pickup
    for(int i=0;i<nullyHatList.size();i++){
      Hat h = nullyHatList.get(i);
      if(collider.checkCol(h.collider)){
        if(h.active){
          ;
        }else{
          hatList.add(h);
          nullyHatList.remove(h);
          h.master=this;
          h.thrown=false;
        }
      }
    }
  }
  
  void show(){
    pushMatrix();
    translate(x,y);
    if(!faceRight){
      scale(-1,1);
    }
    if(xv<=1&&xv>=-1){
      radian-=(radian%(2*PI)-0)/10;
    }
    //player rotation
    rotate(radian);
    image(sprite,0,0,25,25);
    popMatrix();
  }
}
