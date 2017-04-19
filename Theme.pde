class Theme {
  int themeNum;
  
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
  
  AudioPlayer bgSound;
  AudioPlayer dartSound;
  AudioPlayer iceSound;
  AudioPlayer bombSound;
  AudioPlayer laserSound;
  
  Theme (int themeNum) {
    this.themeNum = themeNum;
    
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
  }
}