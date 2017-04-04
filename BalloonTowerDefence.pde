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
PImage pinkBalloonPic;
PImage rainbowBalloonPic;

PImage dartPic;
PImage bombPic;
PImage laserPic;

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

int popCount = 0;                     // count number of popped balloons in current round
int health = 0;
int money = 0;

int totalRoundHealth = 50;       // total health of balloons in current round
int createdRoundHealth = 0;      // total health of created balloons in current round
int totalRounds = 30;            // total rounds of a map
int currentRound = 1;      
float difficultyLevel = 1.5;     // level of difficulty
int oldFrame = 0;                // old frameCount
int balloonNum = 0;            // number of balloon in a round havebeen created
int balloonDelay = 25;

void setup() {
  
  //--------------------setup basic---------------------//
  size(800, 520);
  //background(loadImage("./Pic/loading.png"));
  rectMode(CORNERS);
  imageMode(CENTER);
  W = width/2;
  H = height/2;
  noStroke();
  frameRate(SLOW);
  
  
  //-----------------------load images-----------------------//
  //balloons' images
  redBalloonPic     = loadImage("./Pic/redballoon.png");
  blueBalloonPic    = loadImage("./Pic/blueballoon.png");
  greenBalloonPic   = loadImage("./Pic/greenballoon.png");
  yellowBalloonPic  = loadImage("./Pic/yellowballoon.png");
  pinkBalloonPic    = loadImage("./Pic/pinkballoon.png");
  rainbowBalloonPic = loadImage("./Pic/rainbowballoon.png");
  
  //towers' images
  dartMonkeyPic  = loadImage("./Pic/dart_monkey.png");
  iceTowerPic    = loadImage("./Pic/ice_tower.png");
  bombTowerPic   = loadImage("./Pic/bomb_tower.png");
  superMonkeyPic = loadImage("./Pic/super_monkey.png");
  
  //weapons' images
  dartPic  = loadImage("./Pic/dart.png");
  bombPic  = loadImage("./Pic/dart.png");
  laserPic = loadImage("./Pic/dart.png");
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");
  
  
  //----------------------create objects---------------------//
  PImage bg;
  Button buttonList [];
  
  //---------create menu screen-----------
  bg = loadImage("./Pic/map2.jpg");
  
  buttonList = new Button[] {
    new NewGameButton(100, 100, 200, 300)
  };
  
  menuScreen = new Screen(bg, buttonList, color(255, 0, 0, 100));

  //---------create menu screen-----------
  bg = loadImage("./Pic/map1.jpg");
  
  buttonList = new Button[] {
    new NewDartMonkey(0, 0, 100, 100),
    new NewIceTower(0, 100, 100, 200),
    new NewBombTower(0, 200, 100, 300),
    new NewSuperMonkey(0, 300, 100, 400),
  };
  
  playScreen = new Screen(bg, buttonList, color(255, 0, 0, 100));
  
  //-----------------------------show menu----------------------------//
  screen = menuScreen;
  fill(WHITE);
  background(screen.bg);
  rect(100,100,200,300);
  fill(0,255,255,100);


  //--------------------------------tmp--------------------------------//
  track = new Track("test");
  String string_list [] = loadStrings("./Data/data");
  track.x = new float [string_list.length];
  track.y = new float [string_list.length];
  for (int i=0; i<string_list.length; i++) {
    track.x[i] = toInt(split(string_list[i], " ")[0]);
    track.y[i] = toInt(split(string_list[i], " ")[1]);
  }
  balloonList = new Balloon [] {
    new GreenBalloon(),
    new BlueBalloon(),
    new RainbowBalloon(),
    new RedBalloon(),
  };
  balloonList[0].status = 0;
  health = 100;
  money = 500;
}