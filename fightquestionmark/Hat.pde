public class Hat{
  Player master;
  PImage sprite;
  Boolean thrown;
  float x;
  float y;
  float xv;
  float yv;
  
  public Hat(Player p, PImage s){
    master = p;
    sprite = s;
    thrown = false;
    x = p.x;
    y = p.y;
    xv = 0;
    yv = 0;
  }
  
  void update(){
    if(!thrown){
      float distx = master.x-x;
      float disty = master.y-y;
      xv=distx*0.65;
      yv=disty*0.65;
      x+=xv;
      y+=yv;
    }else{
      //action if thrown
    }
  }
  
  void show(){
    if(!thrown){
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
    }
  }
}
