//constant var
float SELL_PERCENT = 0.8;
int CLICK_TIME = 100;
color WHITE = color(100,100,100,100);
color RED = color(255,0,0,100);
float w;
float h;

//constant object
Screen menuScreen;
Screen playScreen;

//change
Screen screen;
Track track;

boolean starting = true;// balloon or not
boolean pausing = true; // menu vs game

Balloon balloonList [] = {};
Tower towerList [] = {};
Tower chosenTower = null;
Tower buildingTower = null;
boolean buildingTowerConflict = false;
Weapon weaponList [] = {};

int balloonCount = 0;//>>>><<<
int health = 500;
int money = 0;

//thread lock
int draw;

void setup() {
  //----------setup basic----------//
  size(799,519);
  //background(./Pic/loading.png);
  rectMode(CORNERS);
  imageMode(CENTER);
  w = width/2;
  h = height/2;
  noStroke();
  frameRate(60);
  
  //---------create objects-----------//
  
      
  //create menu screen
  PImage bg = loadImage("./BTD/map.png");
  Button buttonList [] = new Button[] {new NewGameButton(100,100,200,300), new GoButton(200,100,300,300)};
  menuScreen = new Screen(bg, buttonList, color(255,0,0,100));
  
  //create game screen
  bg = loadImage("./BTD/map.png");
  buttonList = new Button[] {new NewDarkMonkey(0,0,100,100), new GoButton(200,0,400,200), new SellButton(100,0,200,100) };
  playScreen = new Screen(bg, buttonList, color(0,0,255,100));
  
  
  //-----------show menu--------------//
  menu();
  
  //----------tmp------------//
  track = new Track("test");
  String string_list [] = loadStrings("../test/test_path/data");
  track.x = new float [string_list.length];
  track.y = new float [string_list.length];
  for (int i=0; i<string_list.length; i++) {
    track.x[i] = toInt(split(string_list[i]," ")[0]);
    track.y[i] = toInt(split(string_list[i]," ")[1]);
  }
  balloonList = (Balloon []) append(balloonList, new RedBalloon(0));
}