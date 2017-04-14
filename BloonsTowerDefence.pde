//----------------------------------------------------------------------------------------------//
//                                                                                              //
//                              PROJECT: BLOONS TOWER DEFENCE                                   //
//                                                                                              //
//          Class:      Computer Science Foundation                                             //
//          Due date:   April 18th ,2017                                                        //
//          Team member:    Duong Thanh Hung        Nguyen Tuan Kiet                            //
//                          Nguyen Thanh Long       Huynh Vinh Long                             //
//                          Le Hong Thang           Quach Tri Thong                             //
//          Reference: Bloons tower defence 5 (Ninja Kiwi)                                      //
//                     https://ninjakiwi.com/Games/Tower-Defense/Bloons-Tower-Defense-5.html    //
//                                                                                              //
//----------------------------------------------------------------------------------------------//



//constants
float SELL_PERCENT = 0.8;                 // percent of original price player can get when sell a tower
int   TOTAL_ROUNDS = 30;                  // total rounds of a map
float DIFFICULTY   = 1.2;                 // determine how fast total number of balloon in one round increasessssssss  

color WHITE       = color(100, 100, 100, 100);   
color RED         = color(255, 0, 0, 100);
color BLUE        = color(0, 150, 250, 100);
color CLEAR_BLUE  = color(50, 180, 250, 70);

int FAST = 50;                            // frame rate 
int SLOW = 25;                            // frame rate

int BALLOON_LIST_SIZE = 2000;
int WEAPON_LIST_SIZE  = 3000;
int EFFECT_LIST_SIZE  = 1000;

//---------constant objects, initialized in setup-------------------
Screen menuScreen;
Screen playScreen;
Screen winScreen;
Screen loseScreen;
Screen highScoreScreen;
Screen choosingTrackScreen;

PImage sellButtonPic;
PImage startArrowPic;

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

PImage explosionPic;
PImage snowPic;

PImage map[] = new PImage [3];

PFont fontSmall;
PFont fontMedium;
PFont fontLarge;


//--------------------sound effects--------------------
import ddf.minim.*;
Minim minim;
AudioPlayer bgSound;
AudioPlayer dartSound;
AudioPlayer iceSound;
AudioPlayer bombSound;
AudioPlayer laserSound;

boolean musicEnable = true;
boolean soundEnable = true;


//----------------changeable objects-------------------
Screen screen;
Track track;

boolean starting = false;                  // true: player start a round;    false: round if finished
boolean pausing = true;                    // true: menu;                    false: in game

Balloon balloonList [] = new Balloon [BALLOON_LIST_SIZE];
Weapon weaponList []   = new Weapon [WEAPON_LIST_SIZE];
Effect effectList []   = new Effect [EFFECT_LIST_SIZE];
Tower towerList []     = {};

Tower chosenTower   = null;                // the tower that currently being selected
Tower buildingTower = null;                // the tower to-be-built
boolean buildingTowerConflict = false;     // true if buildingTower is too close to balloon path or too close other towers

int health = 0;
int money  = 0;

int currentRound          = 0;
int totalBalloonInRound   = 0;             // total number of balloons in current round
int createdBalloonInRound = 0;             // number of created balloons in current round
int popCount              = 0;             // count number of popped balloons in current round
int weaponNum = 0;                         // number of weapon created in current round
int effectNum = 0;                         // number of effect in current round

int oldFrame        = 0;                   // save frame since the last time a balloon was created
int newBalloonDelay = 25;                  // delay time between creation of two balloons; will receive random values in game

int highscore [][];                        // save highscores for each track
boolean achievedHighscore = false;

String message;                            // save a message to display on screen when playing 
int messageTime = 0;                       // how long the message will stay on screen



void setup() {
  
  //--------------------setup basic---------------------//
  size(800, 520);  
  rectMode(CORNERS);
  imageMode(CENTER);
  noStroke();
  frameRate(SLOW);
  minim = new Minim(this);
  
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
  bombPic  = loadImage("./Pic/note7.png");
  laserPic = loadImage("./Pic/laser.png");
  
  //effects' images
  explosionPic = loadImage("./Pic/explosion.png");
  snowPic      = loadImage("./Pic/dart.png");
  
  //backgrounds' images
  for (int i=0; i<3; i++)
    map[i] = loadImage("./Pic/map" + str(i) + ".jpg");
  
  sellButtonPic = loadImage("./Pic/sell_button.png");
  startArrowPic = loadImage("./Pic/start_arrow.png");
  
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");
  
  
  //-----------------------load sounds-----------------------//
  bgSound    = minim.loadFile("./Sound/bg.mp3"); 
  dartSound  = minim.loadFile("./Sound/pop.mp3");
  bombSound  = minim.loadFile("./Sound/bomb.mp3");
  laserSound = minim.loadFile("./Sound/laser.mp3");
  iceSound   = minim.loadFile("./Sound/ice.mp3");
  
  
  //----------------------create objects---------------------//
  PImage bg;
  Button buttonList [];
  
  //---------create menu screen-----------
  bg = loadImage("./Pic/menu.jpg");
  buttonList = new Button[] {
    new NewGameButton(15, 440, 250, 480), 
    new QuitButton(730, 10, 790, 70),
    new LoadGameButton(280, 440, 515, 480),
    new HighScoreButton(555, 440, 785, 480),
  };
  menuScreen = new Screen(bg, buttonList);

  //--------create game screen-------------  
  buttonList = new Button[] {
    new SellButton(720, 310, 780, 370),
    new SaveGameButton(700, 390, 795, 415),
    new MenuButton(700, 425, 730, 450),
    new MusicButton(735, 425, 765, 450),
    new SoundButton(765, 425, 795, 450),
    new FastOrSlowButton(705, 460, 800, 520),
    new NewDartMonkey(705, 80, 750, 120), 
    new NewBombTower(705, 130, 750, 170),
    new NewIceTower(755, 80, 800, 120),
    new NewSuperMonkey(755, 130, 800, 170)
  };
  playScreen = new Screen(bg, buttonList);
   
  //--------create choosing track screen------------
  bg = loadImage("./Pic/tracks.jpg");
  buttonList = new Button[] {
    new ChooseTrackButton(85, 135, 285, 275, 0),
    new ChooseTrackButton(290, 125, 495, 285, 1),
    new ChooseTrackButton(500, 140, 710, 290, 2),
    new MenuButton(655, 55, 695, 110)
  };
  choosingTrackScreen = new Screen(bg, buttonList);
  
  //---------create win screen-------------
  bg = loadImage("./Pic/win.jpg");
  buttonList = new Button[] {
    new MenuButton(415, 310, 495, 370)
  };
  winScreen = new Screen(bg, buttonList);
  
  //-----------create lose screen-------------
  bg = loadImage("./Pic/lose.jpg");
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
  };
  loseScreen = new Screen(bg, buttonList);
  
  //-----------create high score screen-------------  
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button[] {
    new MenuButton(750, 475, 790, 512)
  };
  highScoreScreen = new Screen(bg, buttonList);
  

  //-----------------------------show menu----------------------------//
  screen = menuScreen;
  pausing = true;
}