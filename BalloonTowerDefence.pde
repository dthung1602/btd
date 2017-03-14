//constant
float SELL_PERCENT = 0.8;
int CLICK_TIME = 100;
final color WHITE = color(100,100,100,100);
color RED = color(255,0,0,100);
float w;
float h;

//constant object
Screen menuScreen;
Screen playScreen;

//change
Screen screen;
Track track;
Game game;
boolean starting = false;// balloon or not
boolean pausing = true; // menu vs game

void setup() {
  //----------setup basic----------//
  size(800,500);
  //background(./Pic/loading.png);
  rectMode(CORNERS);
  imageMode(CENTER);
  w = width/2;
  h = height/2;
  noStroke();
  frameRate(60);
  
  //---------create objects-----------//
  
  //*create track
  track = new Track("abc");
  track.level = 1;
  track.x = new float [] {width-100,width-100,-100};
  track.y = new float [] {200,400,400};
  track.xSpeed = new float [] {5,0,-5};
  track.ySpeed = new float [] {0,5,0};
  track.trackWidth = 20;
  track.bg = loadImage("./Pic/background.jpg");
  track.balloonList = new Balloon [] {new RedBalloon(-900,200), new RedBalloon(-500,200), new RedBalloon(-300,200)};
  track.defaultHealth = 5;
  track.defaultMoney = 100;
  
  //*create game
  game = new Game("ths");
  game.x = track.x;
  game.y = track.y;
  game.balloonList = track.balloonList;
  game.health = track.defaultHealth;
  game.money = track.defaultMoney;
  game.balloonCount = game.balloonList.length;
  game.towerList = new Tower [] {new DartMonkey(150,200), new DartMonkey(500,300), new DartMonkey(700,400)};
  //game.chosenTower = game.towerList[0];
  game.buildingTower = new DartMonkey(0,0);
  
  
  //create menu screen
  PImage bg = loadImage("./Pic/menubg.jpg");
  Button buttonList [] = new Button[] {new NewGameButton(100,100,200,300), new GoButton(200,100,300,300)};
  menuScreen = new Screen(bg, buttonList, color(255,0,0,100));
  
  //create game screen
  bg = loadImage("./Pic/background.jpg");
  buttonList = new Button[] {new NewGameButton(0,0,100,100), new GoButton(200,0,400,200)};//{new GoButton(0,0,w,h), new GoButton(w,0,width,h), new NewGameButton(0,h,width,height)};
  playScreen = new Screen(bg, buttonList, color(0,0,255,100));
  
  
  //-----------show menu--------------//
  menu();
  
  //----------tmp------------//
}