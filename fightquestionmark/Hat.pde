public class Hat{
  Player master;
  PImage sprite;
  Boolean thrown, active;
  float x, y, xv, yv, radian;
  CirCol collider;
  
  public Hat(Player p, PImage s){
    master = p;
    sprite = s;
    thrown = false;
    active = false;
    x = p.x;
    y = p.y;
    xv = 0;
    yv = 0;
    radian = 0;
    collider = new CirCol(x,y,25);
  }
  
  void update(){
    if(!master.dead){
      if(!thrown){
        //action if on head
        float distx = master.x-x;
        float disty = master.y-y;
        active=false;
        xv=distx*0.65;
        yv=disty*0.65;
        x+=xv/((master.hatList.indexOf(this)+1)*0.7);
        y+=(yv-master.hatList.indexOf(this)*8)/(master.hatList.indexOf(this)+1)+abs(xv/20);
      }else{
        //action if thrown
        if(master!=nully){//hat collision
          for(int i=0;i<master.other.hatList.size();i++){
            Hat h = master.other.hatList.get(i);
            if(h.collider.checkCol(collider)&&h.thrown){
              xv*=-0.1;
              yv=-1;
              h.xv*=-0.1;
              h.yv=-1;
              master.hatList.remove(this);
              nully.hatList.add(this);
              master=nully;
              break;
            }
          }
        }
        //not floor collision
        if(active){
          yv+=0.1;
          radian+=0.2;
          if(x<=0||x>=width){
            master.hatList.remove(this);
          }
          //checking for platforms
          checkLevel(lvl);
        }else{
          //if on ground
          active = false;
          master.hatList.remove(this);
          master=nully;
          nullyHatList.add(this);
          y-=yv;
          yv = 0;
          xv*=0.4;
        }
        
        checkPath();
        
        //MOVEMENT
        x += xv;
        y += yv;
      }
      if(master.faceRight){
        collider.x=x-10;
        collider.y=y-10;
      }else{
        collider.x=x+10;
        collider.y=y-10;
      }
    }else{
      master.hatList.remove(this);
      nully.hatList.add(this);
      master=nully;
      thrown=true;
      active=true;
      yv=-5;
      xv=random(-5,6);
    }
  }

  void show(){
    //collider.render();
    if(!master.dead){
      if(!thrown){
        //action if on head
        pushMatrix();
        if(!master.faceRight){
          translate(x+8,y-9);
          scale(-1,1);
        }else{
          translate(x-8,y-9);
        }
        image(sprite,0,0,25,25);
        popMatrix();
      }else{
        //action if thrown
        pushMatrix();
        translate(x-10,y-10);
        rotate(radian);
        image(sprite,0,0,25,25);
        popMatrix();
      }
    }
  }
    
  void checkPath()
  {
    Vector next = new Vector(x + xv, y + yv);
    
    CirCol c = new CirCol(x,y,20);
    
    float xDis;
    float yDis;
    
    Vector slope = new Vector(next.x - x, next.y - y);
    
    float div = 100;
    
    for(int j = 0; j < div; j++)
    {
      if(checkClose(c, lvl))
      {
        break;
      }
      
      c.x += slope.x*(1/div);
      c.y += slope.y*(1/div);
    }
    
    xDis = c.x - x;
    yDis = c.y - y;
    
    //if under this value, do things
    float min = 0.1;
    
    if(yDis < min)
    {
      if(active && checkClose(collider,lvl))
      {
        Ground();
      }
      else if(active && !checkClose(collider,lvl))
      {
        y += 1;
      }

    }
    
    if(xDis < min)
    {
      if(active)
      {
        x += -xv*5;
        xv = -xv*2;
        
        yv = yDis;
        
      }
    }
    
    xv = xDis;
    yv = yDis;
    checkLevel(lvl);
    

  }
  
  boolean checkClose(CirCol c,Level curL)
  {
    if(curL != null)
    {
      float dmin=999;
      Platform p = lvl.platforms.get(0);
      for(Platform pl:curL.platforms)
      {
        float d=sqrt(pow(lvl.getGrid(pl.gridX,pl.gridY)[0]-c.x,2)+pow(lvl.getGrid(pl.gridX,pl.gridY)[1]-c.y,2));
        if(dmin>d){
          dmin=d;
          p=pl;
        }
      }
      return c.checkCol(p.collider);
      
    }
    else
      return false;
  }
  
  void checkLevel(Level curL)
  {
    if(curL != null)
    {
      for(Platform pl:curL.platforms)
      {
        if(pl != null && pl.collider != null)
          this.CollidePlatform(pl.collider);
      }
    }
  }

  
  void CollidePlatform(BoxCol b)
  {
    if(collider.checkCol(b))
    {
      
      if(y < b.y)
      { 
        Ground();
        
        y = b.y - b.xSize/2;
        
        yv = 0;
        
        if(yv > 0)
          yv = 0;
      }
      else if(y > b.y)
      {
         yv = 2;
        
        if(yv < 0)
          yv = 0;
      }
      
      
      
    }
  }
  
  void Ground()
  {
    active = false;
    
    master.hatList.remove(this);
    master=nully;
    nullyHatList.add(this);
  }
  
  float dis(float x1, float y1, float x2, float y2)
  {
    return sqrt( pow(x1 - x2,2) + pow(y1 - y2,2));
  }
}
