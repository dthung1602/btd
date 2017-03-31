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


//constant var
float SELL_PERCENT = 0.8;                 // percent of original price player can get when sell a tower
int CLICK_TIME = 100;                     // delay time before recheck mouse click when game is paused
color WHITE = color(100, 100, 100, 100);   
color RED = color(255, 0, 0, 100);
float W;                                  // = width/2
float H;                                  // = height/2


//constant objects, intialize in setup
Screen menuScreen;
Screen playScreen;

PImage dartMonkeyPic;
PImage iceTowerPic;
PImage bombTowerPic;
PImage superMonkeyPic;

PImage redBalloonPic;
PImage blueBalloonPic;
PImage greenBalloonPic;
PImage yellowBalloonPic;

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
  //----------setup basic----------//
  size(799, 519);
  //background(./Pic/loading.png);
  rectMode(CORNERS);
  imageMode(CENTER);
  W = width/2;
  H = height/2;
  noStroke();
  frameRate(60);
  
  //---------load images-------------//
  redBalloonPic = loadImage("./Pic/redballoon.png");
  dartMonkeyPic = loadImage("./Pic/dart_monkey.png");
  
  //---------create objects-----------//


  //create menu screen
  PImage bg = loadImage("./Pic/map.png");
  Button buttonList [] = new Button[] {
    new NewGameButton(100, 100, 200, 300), 
    new GoButton(200, 100, 300, 300)
  };
  menuScreen = new Screen(bg, buttonList, color(255, 0, 0, 100));

  //create game screen
  bg = loadImage("./Pic/map.png");
  buttonList = new Button[] {
    new NewDarkMonkey(0, 0, 100, 100), 
    new GoButton(200, 0, 400, 200), 
    new SellButton(100, 0, 200, 100)
  };
  playScreen = new Screen(bg, buttonList, color(0, 0, 255, 100));


  //-----------show menu--------------//
  screen = menuScreen;
  fill(WHITE);
  background(screen.bg);
  rect(100,100,200,300);
  rect(200,100,300,300);
  fill(0,255,255,100);

  //----------tmp------------//
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