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
    if(!thrown){
      //action if on head
      float distx = master.x-x;
      float disty = master.y-y;
      xv=distx*0.65;
      yv=disty*0.65;
      x+=xv;
      y+=yv;
    }else{
      //action if thrown
      if(!collider.checkCol(floorCol)&&active){
        yv+=0.1;
        radian+=0.2;
      }else{
        active = false;
        master=nully;
        yv = 0;
        y = floorCol.y-floorCol.ySize/2;
        xv*=0.3;
      }
      y+=yv;
      x+=xv;
    }
    if(master.faceRight){
      collider.x=x-10;
      collider.y=y-10;
    }else{
      collider.x=x+10;
      collider.y=y-10;
    }
  }
  
  void show(){
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
