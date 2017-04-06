//----------------------------------------------------------------------------------------------//
//                                                                                              //
//                              PROJECT: BALLOON TOWER DEFENCE                                  //
//                                                                                              //
//          Class:      Computer Science Foundation                                             //
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

color WHITE = color(100, 100, 100, 100);   
color RED = color(255, 0, 0, 100);
color BLUE = color(0, 150, 250, 100);

float W;                                  // = width/2
float H;                                  // = height/2

int FAST = 50;                            // frame rate 
int SLOW = 25;                            // frame rate

int BALLOON_LIST_SIZE = 500;
int WEAPON_LIST_SIZE = 1500;

//constant objects, initialized in setup
Screen menuScreen;
Screen playScreen;
Screen winScreen;
Screen loseScreen;
Screen highScoreScreen;
Screen choosingTrackScreen;

PImage sellButtonPic;

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

PImage map[] = new PImage [3];

PFont fontSmall;
PFont fontMedium;
PFont fontLarge;

//changeable objects
Screen screen;
Track track;

boolean starting = false;                  // true: player start a round;    false: round if finished
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

int totalBalloonInRound = 0;       // total health of balloons in current round
int createdBalloonInRound = 0;      // total health of created balloons in current round
int totalRounds = 30;            // total rounds of a map
int currentRound = 1;      
float difficultyLevel = 1.3;     // level of difficulty
int oldFrame = 0;                // old frameCount
int balloonNum = 0;            // number of balloon in a round havebeen created
int weaponNum = 0;
int newBalloonDelay = 25;

int highscore [][];
boolean achievedHighscore;

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
  bombPic  = loadImage("./Pic/bomb.png");
  laserPic = loadImage("./Pic/laser.png");
  
  //backgrounds' images
  for (int i=0; i<3; i++)
    map[i] = loadImage("./Pic/map" + str(i) + ".jpg");
  
  sellButtonPic = loadImage("./Pic/sell_button.png");
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");
  
  
  //----------------------create objects---------------------//
  PImage bg;
  Button buttonList [];
  
  //---------create menu screen-----------
  bg = loadImage("./Pic/menu.jpg");
  
  buttonList = new Button[] {
    new NewGameButton(15, 440, 250, 480), 
    //new QuitButton(200, 100, 300, 300),
    new LoadGameButton(280, 440, 515, 480),
    new HighScoreButton(555, 440, 785, 480),
  };
  
  menuScreen = new Screen(bg, buttonList, color(255, 0, 0, 100));

  //--------create game screen-------------  
  buttonList = new Button[] {
    new SellButton(700, 0, 200, 100),
    new NewDartMonkey(705, 80, 750, 120), 
    new NewBombTower(705, 130, 750, 170),
    new NewIceTower(755, 80, 800, 120),
    new NewSuperMonkey(755, 130, 800, 170), 
    new MenuButton(700, 425, 730, 450),
    new SaveGameButton(700, 390, 795, 415),
    new FastOrSlowButton(705, 460, 800, 520)
  };
  
  playScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));
   
  //--------create choosing track screen------------
  bg = loadImage("./Pic/tracks.jpg");
  
  buttonList = new Button[] {
    new ChooseTrackButton(85, 135, 285, 275, 0),
    new ChooseTrackButton(290, 125, 495, 285, 1),
    new ChooseTrackButton(500, 140, 710, 290, 2),
    new MenuButton(655, 55, 695, 110)
  };
  
  choosingTrackScreen = new Screen(bg, buttonList, color(255, 100, 100));
  
  //---------create win screen-------------
  bg = loadImage("./Pic/win.jpg");
  
  buttonList = new Button[] {
    new MenuButton(415, 310, 495, 370)
  };
  
  winScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));
  
  //-----------create lose screen-------------
  bg = loadImage("./Pic/lose.jpg");
  
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
  };
  
  loseScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));
  
  //-----------create high score screen-------------  
  bg = loadImage("./Pic/highscore.jpg");
  
  buttonList = new Button[] {
    new MenuButton(100, 0, 200, 100)
  };
  
  highScoreScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));
  
  
  //-----------------------------show menu----------------------------//
  screen = menuScreen;
  pausing = true;

  //--------------------------------tmp--------------------------------//
  /*track = new Track("test");
  String string_list [] = loadStrings("./Data/data");
  track.x = new float [string_list.length];
  track.y = new float [string_list.length];
  for (int i=0; i<string_list.length; i++) {
    track.x[i] = int(split(string_list[i], " ")[0]);
    track.y[i] = int(split(string_list[i], " ")[1]);
  }
  balloonList = new Balloon [BALLOON_LIST_SIZE];
  weaponList  = new Weapon [WEAPON_LIST_SIZE];
  totalBalloonInRound = 10;
  health = 2;
  money = 500;*/
}