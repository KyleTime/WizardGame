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
    }
  }
  
  void show(){
    if(!master.faceRight){
      scale(-1,1);
    }
    translate(x-20,y+2);
    image(sprite,0,0,70,70);
    translate(-(x-20),-(y+2));
    if(!master.faceRight){
      scale(-1,1);
    }
  }
}
