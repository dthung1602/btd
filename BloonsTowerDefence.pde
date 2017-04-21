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

int FAST = 75;                            // frame rate 
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
Screen settingScreen;

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
Theme theme;
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
  surface.setResizable(true);
  rectMode(CORNERS);
  imageMode(CENTER);
  noStroke();
  frameRate(SLOW);
  minim = new Minim(this);
  
  //--------------------load theme----------------------//
  theme = new Theme(0);
 
  //-----------------------------show menu----------------------------//
  screen = menuScreen;
  pausing = true;
}