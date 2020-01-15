Player p1, p2;
BoxCol p1Col, p2Col, floorCol;
Hat p1h, p2h;
PImage playerSprite, hatSprite;
float floorHeight;
Boolean p1n = false,p1s = false,p1w = false,p1e = false,p2n = false,p2s = false,p2w = false,p2e = false;

void setup(){
  //basic setup
  size(1300,800);
  imageMode(CENTER);
  
  //floor set and collider
  floorHeight = height/3*2;
  floorCol = new BoxCol(width/2, height*0.9, width, height/2);
  
  //sprites
  playerSprite = loadImage("/Resources/player.png");
  hatSprite = loadImage("/Resources/hat.png");
  
  //p1 definition
  p1 = new Player(true,width/4,height/2,playerSprite);
  p1Col = new BoxCol(p1.x,p1.y,25,25);
  p1.getCollider(p1Col);
  p1h = new Hat(p1,hatSprite);
  p1.spawn();
  
  //p2 definition
  p2 = new Player(false,width/4*3,height/2,playerSprite);
  p2Col = new BoxCol(p2.x,p2.y,25,25);
  p2.getCollider(p2Col);
  p2h = new Hat(p2,hatSprite);
  p2.spawn();
  
  p1.getOtherPlayer(p2);
  p2.getOtherPlayer(p1);
}


void draw(){
  //bg draw
  background(0);
  stroke(200);
  fill(100);
  floorCol.render();
  
  //movement functions
  if(p1n&&p1.onGround)p1.yv=-8;
  if(p1w&&p1.xv>-8)p1.xv-=1;
  if(p1e&&p1.xv<8)p1.xv+=1;
  if(p2n&&p2.onGround)p2.yv=-8;
  if(p2w&&p2.xv>-8)p2.xv-=1;
  if(p2e&&p2.xv<8)p2.xv+=1;
  
  //update functions
  p1.update();
  p1.show();
  p1h.update();
  p1h.show();
  p2.update();
  p2.show();
  p2h.update();
  p2h.show();
}


void keyPressed(){
  //p1 controls
  if(key=='w')p1n=true;
  if(key=='a')p1w=true;
  if(key=='s')p1s=true;
  if(key=='d')p1e=true;
  //p2 controls
  if(keyCode==UP)p2n=true;
  if(keyCode==LEFT)p2w=true;
  if(keyCode==DOWN)p2s=true;
  if(keyCode==RIGHT)p2e=true;
}


void keyReleased(){
  if(key=='w')p1n=false;
  if(key=='a')p1w=false;
  if(key=='s')p1s=false;
  if(key=='d')p1e=false;
  if(keyCode==UP)p2n=false;
  if(keyCode==LEFT)p2w=false;
  if(keyCode==DOWN)p2s=false;
  if(keyCode==RIGHT)p2e=false;
}
