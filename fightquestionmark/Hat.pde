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
      active=false;
      xv=distx*0.65;
      yv=disty*0.65;
      x+=xv/((master.hatList.indexOf(this)+1)*0.7);
      y+=(yv-master.hatList.indexOf(this)*8)/(master.hatList.indexOf(this)+1)+abs(xv/20);
    }else{
      //action if thrown
      if(master!=nully){
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
      if(!collider.checkCol(floorCol)&&active){
        yv+=0.1;
        radian+=0.2;
        if(x<=0||x>=width){
          master.hatList.remove(this);
        }
      }else{
        //if on ground
        active = false;
        master.hatList.remove(this);
        master=nully;
        nullyHatList.add(this);
        yv = 0;
        y = floorCol.y-floorCol.ySize/2;
        xv*=0.4;
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
}
