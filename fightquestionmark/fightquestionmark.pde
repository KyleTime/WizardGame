Player p1, p2, nully;
BoxCol p1Col, p2Col, nullyCol, floorCol;
ArrayList<Hat> p1HatList = new ArrayList();
ArrayList<Hat> p2HatList = new ArrayList();
ArrayList<Hat> nullyHatList = new ArrayList();
PImage playerSprite;
ArrayList<PImage> hatSprite;
float floorHeight, hatTimer, resTimer;
Boolean p1n = false,p1s = false,p1w = false,p1e = false,p2n = false,p2s = false,p2w = false,p2e = false,pBlock=false,bBlock=false,showPlace=false;
String filePath = "/Resources/Levels/level.txt";
PFont textFont;

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
  textFont = createFont("/Resources/Fonts/slkscr.ttf",32);
  textFont(textFont);
  textAlign(CENTER);
  
  //floor set and collider
  floorHeight = height/3*2;
  
  //base level
  for(int x = 0;x<width/lvl.tileXSize+1;x++){
    for(int y = (int)(floorHeight/lvl.tileYSize);y<height/lvl.tileYSize+1;y++){
      lvl.platforms.add(new Platform(x,y,lvl));
    }
  }
  
  //sprites
  playerSprite = loadImage("/Resources/Player.png");

  loadHats();
  
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
  
  hatTimer = 3;
  resTimer = 5;
}

void loadHats()
{
  hatSprite = new ArrayList<PImage>();
  for(int x = 0; x < 100; x++)
  {
    PImage cur = loadImage("/Resources/hat" + x + ".png");
    
    if(cur != null)
    {
      hatSprite.add(cur);
    }
  }
}


void draw(){
  
  //bg draw
  background(0);
  stroke(200);
  fill(100);
  
  //making text size normal
  textSize(32);
  
  //hat spawning
  hatTimer-=0.016;
  if(hatTimer<=0){
    nully.x=random(width/4, width/4*3);
    //SPAWN HATS
    nullyHatList.add(new Hat(nully, hatSprite.get((int)random(0,hatSprite.size()))));
    nullyHatList.get(nullyHatList.size()-1).thrown=true;
    nullyHatList.get(nullyHatList.size()-1).active=true;
    hatTimer=10;
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
  //block placement
  if(pBlock&&showPlace){
    int x = (int)(mouseX/lvl.tileXSize);
    int y = (int)(mouseY/lvl.tileYSize);
    Boolean place = true;
    for(Platform p:lvl.platforms){
      if(x==p.gridX&&y==p.gridY){
        place=false;
        break;
      }
    }
    if(place){
      lvl.platforms.add(new Platform((int)(mouseX/lvl.tileXSize),(int)(mouseY/lvl.tileYSize),lvl));
    }
    lvl.update();
  }
  //block removal
  if(bBlock&&showPlace){
    int x = (int)(mouseX/lvl.tileXSize);
    int y = (int)(mouseY/lvl.tileYSize);
    for(int i=0;i<lvl.platforms.size();i++){
      Platform p = lvl.platforms.get(i);
      if(x==p.gridX&&y==p.gridY){
        lvl.platforms.remove(p);
      }
    }
  }
  
  lvl.update();
  
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
  
  if(showPlace)nextTile();
  
  fill(255);
  textSize(50);
  if(p1.score>=5||p2.score>=5){
    textSize(100);
    if(p1.score>=5){
      text("P1 WINS",width/2,height/2);
    }else{
      text("P2 WINS",width/2,height/2);
    }
    resTimer-=0.016;
    if(resTimer<=0){
      p1.score=0;
      p2.score=0;
      resTimer=5;
      p1HatList.clear();
      p2HatList.clear();
      nullyHatList.clear();
      p1.spawn();
      p2.spawn();
    }
  }else{
    text(p1.score+" : "+p2.score,width/2,height/6);
  }
}


void keyPressed(){
  if(key=='m')if(showPlace)showPlace=false;else showPlace=true;
  //p1 controls
  if(key=='w')p1n=true;
  if(key=='a')p1w=true;
  if(key=='s')p1s=true;
  if(key=='d')p1e=true;
  if(key=='r'){p1.hatList.clear();p1.dead=true;}
  //p2 controls
  if(keyCode==UP)p2n=true;
  if(keyCode==LEFT)p2w=true;
  if(keyCode==DOWN)p2s=true;
  if(keyCode==RIGHT)p2e=true;
  if(key=='0'){p2.hatList.clear();p2.dead=true;}
  //level save
  if(key=='p'){
    File file = sketchFile(filePath);
    if(file.exists()){
      println("File already exists");
    }else{
      String[] platList = new String[lvl.platforms.size()];
      for(Platform p:lvl.platforms){
        platList[lvl.platforms.indexOf(p)] = p.gridX+" "+p.gridY;
      }
      saveStrings(filePath,platList);
      println("Level saved to: "+filePath);
    }
  }
  if(key=='l'){
    String[] gridCoords = loadStrings(filePath);
    int platListSize = gridCoords.length;
    println(platListSize);
    lvl.platforms.clear();
    for(int i=0;i<platListSize;i++){
      int[] xy = int(split(gridCoords[i], ' '));
      lvl.platforms.add(new Platform(xy[0],xy[1],lvl));
    }
    lvl.update();
  }
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

void nextTile()
{
    float[] point = lvl.getGrid((int)(mouseX/lvl.tileXSize),(int)(mouseY/lvl.tileYSize));
  
  
    fill(100,100);
    rect(point[0] - 15.5, point[1] - 15.5, 31,31);
}

void mousePressed(){
  if(mouseButton==LEFT){
    pBlock=true;
  }else if(mouseButton==RIGHT){
    bBlock=true;
  }
}

void mouseReleased(){
  if(mouseButton==LEFT){
    pBlock=false;
  }else if(mouseButton==RIGHT){
    bBlock=false;
  }
}
