//----------------------------------------------------------------------------------------------//
//                                                                                              //
//                              PROJECT: BALLOON TOWER DEFENCE                                  //
//                                                                                              //
//          Class:  Computer Science Foundation                                                 //
//          Due date:   April 6th ,2017                                                         //
//          Team member:    Duong Thanh Hung        Nguyen Tuan Kiet                            //
//                          Nguyen Thanh Long       Huynh Vinh Long                             //
//                          Le Hong Thang           Quach Tri Thong                             //
//          Reference: Balloon tower defence 5 (Ninja Kiwi)                                     //
//                     https://ninjakiwi.com/Games/Tower-Defense/Bloons-Tower-Defense-5.html    //
//                                                                                              //
//----------------------------------------------------------------------------------------------//



//constants
float SELL_PERCENT = 0.8;                 // percent of original price player can get when sell a tower
int CLICK_TIME = 100;                     // delay time before recheck mouse click when game is paused

color WHITE = color(100, 100, 100, 100);   
color RED = color(255, 0, 0, 100);

float W;                                  // = width/2
float H;                                  // = height/2

int FAST = 50;                            // frame rate 
int SLOW = 25;                            // frame rate


//constant objects, initialized in setup
Screen menuScreen;
Screen playScreen;
Screen winScreen;
Screen loseScreen;
Screen highScoreScreen;

PImage dartMonkeyPic;
PImage iceTowerPic;
PImage bombTowerPic;
PImage superMonkeyPic;

PImage redBalloonPic;
PImage blueBalloonPic;
PImage greenBalloonPic;
PImage yellowBalloonPic;

PFont fontSmall;
PFont fontMedium;
PFont fontLarge;


//changeable objects
Screen screen;
Track track;

boolean starting = true;                  // true: player start a round;    false: round if finished
boolean pausing = true;                   // true: menu;  false: in game

Balloon balloonList [] = {};              
Weapon weaponList [] = {};
Tower towerList [] = {};

Tower chosenTower = null;                 // the tower that currently being selected
Tower buildingTower = null;               // the tower to-be-built
boolean buildingTowerConflict = false;    // true if buildingTower too close to balloon path or to other towers

int balloonCount = 0;                     // count number of popped balloons
int health = 0;
int money = 0;


void setup() {
  
  //--------------------setup basic---------------------//
  size(799, 519);
  //background(loadImage("./Pic/loading.png"));
  rectMode(CORNERS);
  imageMode(CENTER);
  W = width/2;
  H = height/2;
  noStroke();
  frameRate(SLOW);
  
  
  //-----------------------load images-----------------------//
  //balloons' images
  redBalloonPic    = loadImage("./Pic/redballoon.png");
  blueBalloonPic   = loadImage("./Pic/redballoon.png");
  greenBalloonPic  = loadImage("./Pic/redballoon.png");
  yellowBalloonPic = loadImage("./Pic/redballoon.png");
  
  //towers' images
  dartMonkeyPic  = loadImage("./Pic/dart_monkey.png");
  iceTowerPic    = loadImage("./Pic/dart_monkey.png");
  bombTowerPic   = loadImage("./Pic/dart_monkey.png");
  superMonkeyPic = loadImage("./Pic/dart_monkey.png");
  
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");
  
  
  //----------------------create objects---------------------//
  PImage bg;
  Button buttonList [];
  
  //---------create menu screen-----------
  bg = loadImage("./Pic/map.png");
  
  buttonList = new Button[] {
    new NewGameButton(100, 100, 200, 300), 
    new GoButton(200, 100, 300, 300)
  };
  
  menuScreen = new Screen(bg, buttonList, color(255, 0, 0, 100));

  //--------create game screen-------------
  bg = loadImage("./Pic/map.png");
  
  buttonList = new Button[] {
    new NewDarkMonkey(0, 0, 100, 100), 
    new GoButton(200, 0, 400, 200), 
    new SellButton(100, 0, 200, 100)
  };
  
  playScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));

  //---------create win screen-------------
  bg = loadImage("./Pic/map.png");
  
  buttonList = new Button[] {
    new SellButton(100, 0, 200, 100)
  };
  
  winScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));
  
  //-----------create lose screen-------------
  bg = loadImage("./Pic/map.png");
  
  buttonList = new Button[] {
    new SellButton(100, 0, 200, 100)
  };
  
  loseScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));
  
  //-----------create high score screen-------------
  bg = loadImage("./Pic/map.png");
  
  buttonList = new Button[] {
    new SellButton(100, 0, 200, 100)
  };
  
  highScoreScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));
  
  
  //-----------------------------show menu----------------------------//
  screen = menuScreen;
  fill(WHITE);
  background(screen.bg);
  rect(100,100,200,300);
  rect(200,100,300,300);
  fill(0,255,255,100);


  //--------------------------------tmp--------------------------------//
  track = new Track("test");
  String string_list [] = loadStrings("../test/test_path/data");
  track.x = new float [string_list.length];
  track.y = new float [string_list.length];
  for (int i=0; i<string_list.length; i++) {
    track.x[i] = toInt(split(string_list[i], " ")[0]);
    track.y[i] = toInt(split(string_list[i], " ")[1]);
  }
  balloonList = (Balloon []) append(balloonList, new RedBalloon(0));
}