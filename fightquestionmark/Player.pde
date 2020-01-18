public class Player{
  Boolean faceRight, onGround, dead;
  BoxCol collider;
  float spawnx, spawny, x, y, xv, yv, radian, deadTimer;
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
    this.dead = false;
  }
  
  void spawn(){
    x = spawnx;
    y = spawny;
    dead = false;
    this.hatList.add(new Hat(this,hatSprite));
  }
  
  void update(){
    if(!dead){
      yv+=0.3;
      if(onGround){
        xv*=0.9;
      }else{
        xv*=0.99;
      }
      checkLevel(lvl);
      y+=yv;
      x+=xv;
      collider.x = x;
      collider.y = y;
      //render player colliders
      //collider.render();
      //floor collision
      checkLevel(lvl);
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
          hatList.add(h);
          nullyHatList.remove(h);
          h.master=this;
          h.thrown=false;
        }
      }
      //hat death
      for(int i=0;i<other.hatList.size();i++){
        Hat h = other.hatList.get(i);
        if(collider.checkCol(h.collider)&&h.active){
          dead=true;
          deadTimer=3;
        }
      }
      if(y>height){
        dead=true;
      }
    }else{
      deadTimer-=0.016;
      if(deadTimer<=0){
        dead=false;
        this.spawn();
      }
    }
  }
  
  void show(){
    if(!dead){
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
    }else{
      pushMatrix();
      translate(random(x-3,x+4),random(y-3,y+4));
      rotate(radian);
      fill(255,0,0);
      text("DEAD",0,0);
      popMatrix();
    }
  }
  
  void checkLevel(Level curL)
  {
    if(curL != null)
    {
      float dmin=999;
      Platform p = null;
      for(Platform pl:curL.platforms)
      {
        float d=sqrt(pow(lvl.getGrid(pl.gridX,2)[0]-x,2)+pow(lvl.getGrid(pl.gridX,2)[1]-y,2));
        if(dmin>d){
          dmin=d;
          p=pl;
        }
        if(pl.collider != null)
          this.CollidePlatform(pl.collider);
      }
      println(dmin);
      if(p!=null&&!collider.checkCol(p.collider)){
        onGround=false;
      }
    }
  }
  
  void CollidePlatform(BoxCol b)
  {
    if(collider.checkCol(b))
    {
      //check for ground
      if(b.y > this.y && abs(b.x - x) < b.xSize/2)
      {
        onGround = true;
        y = b.y - b.ySize*0.9;
        
        if(yv > 0)
          yv = 0;
      }
      //check ceiling
      if(b.y < this.y && abs(b.x - x) < b.xSize/2)
      {
        y = b.y + b.ySize*0.9;
        
        if(yv < 0)
          yv = 0;
      }
      else if(xv > 0 && b.x > x && abs(b.y - y) < b.ySize/2 + collider.ySize/2 - 10)
      {
        xv = 0;
      }
      //check left wall
      else if(xv < 0 && b.x < x && abs(b.y - y) < b.ySize/2 + collider.ySize/2 - 10)
      {
        xv = 0;
      }
    }
  }
}
