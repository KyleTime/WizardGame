Player p1, p2, nully;
BoxCol p1Col, p2Col, nullyCol, floorCol;
ArrayList<Hat> p1HatList = new ArrayList();
ArrayList<Hat> p2HatList = new ArrayList();
ArrayList<Hat> nullyHatList = new ArrayList();
PImage playerSprite, hatSprite;
float floorHeight, hatTimer;
Boolean p1n = false,p1s = false,p1w = false,p1e = false,p2n = false,p2s = false,p2w = false,p2e = false;

///Platform Stuff

ArrayList<Level> levels = new ArrayList();

//selected level;
Level lvl;
//////////////////////////

void setup(){
  
  levels.add(new Level());
  
  lvl = levels.get(0);
  
  lvl.begin();
  
  //basic setup
  size(1300,800);
  imageMode(CENTER);
  textSize(32);
  textAlign(CENTER);
  
  //floor set and collider
  floorHeight = height/3*2;
  floorCol = new BoxCol(width/2, height*0.9, width, height/2);
  
  //sprites
  playerSprite = loadImage("/Resources/Player.png");
  hatSprite = loadImage("/Resources/hat.png");
  
  //nully definition
  nully = new Player(true,width/2,0,playerSprite,nullyHatList);
  nullyCol = new BoxCol(nully.x,nully.y,25,25);
  nully.collider = nullyCol;
  
  //p1 definition
  p1 = new Player(true,width/4,height/2,playerSprite,p1HatList);
  p1Col = new BoxCol(p1.x,p1.y,25,25);
  p1.collider = p1Col;
  p1.spawn();
  
  //p2 definition
  p2 = new Player(false,width/4*3,height/2,playerSprite,p2HatList);
  p2Col = new BoxCol(p2.x,p2.y,25,25);
  p2.collider = p2Col;
  p2.spawn();
  
  p1.other = p2;
  p2.other = p1;
  
  p1HatList.add(new Hat(p1,hatSprite));
  p2HatList.add(new Hat(p2,hatSprite));
  
  hatTimer = 3;
}


void draw(){
  //bg draw
  background(0);
  stroke(200);
  fill(100);
  floorCol.render();
  
  //hat spawning
  hatTimer-=0.016;
  if(hatTimer<=0){
    nully.x=random(width/4, width/4*3);
    nullyHatList.add(new Hat(nully, hatSprite));
    nullyHatList.get(nullyHatList.size()-1).thrown=true;
    nullyHatList.get(nullyHatList.size()-1).active=true;
    hatTimer=5;
  }
  
  //p1 movement functions
  if(!p1.dead){
    if(p1n&&p1.onGround)p1.yv=-8;
    if(p1w&&p1.xv>-8){p1.xv-=1;p1.radian-=0.5;}
    if(p1e&&p1.xv<8){p1.xv+=1;p1.radian+=0.5;}
    if(p1s&&p1HatList.size()>0){p1.hatList.get(0).thrown=true; p1.hatList.get(0).active=true; p1s=false;}
  }
  //p2 movement functions
  if(!p2.dead){
    if(p2n&&p2.onGround)p2.yv=-8;
    if(p2w&&p2.xv>-8){p2.xv-=1;p2.radian+=0.5;}
    if(p2e&&p2.xv<8){p2.xv+=1;p2.radian-=0.5;}
    if(p2s&&p2HatList.size()>0){p2.hatList.get(0).thrown=true; p2.hatList.get(0).active=true; p2s=false;}
  }
  
  //update functions
  p1.update();
  p1.show();
  p2.update();
  p2.show();
  for(int i=0;i<p1HatList.size();i++){
    Hat h = p1HatList.get(i);
    h.update();
    h.show();
  }
  for(int i=0;i<p2HatList.size();i++){
    Hat h = p2HatList.get(i);
    h.update();
    h.show();
  }
  for(int i=0;i<nullyHatList.size();i++){
    Hat h = nullyHatList.get(i);
    h.update();
    h.show();
  }
  
    lvl.update();
    
    
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

void mousePressed(){
  lvl.platforms.add(new Platform((int)(mouseX/lvl.tileXSize),(int)(mouseY/lvl.tileYSize),lvl));
}
