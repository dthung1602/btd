class Theme {
  int themeNum;
  
  Theme (int num) {
    this.themeNum = num;
    
    //-----------------------load images-----------------------// 
    //balloons' images
    redBalloonPic     = loadImage("./Themes/Theme" + themeNum + "/Pic/redballoon.png");
    blueBalloonPic    = loadImage("./Themes/Theme" + themeNum + "/Pic/blueballoon.png");
    greenBalloonPic   = loadImage("./Themes/Theme" + themeNum + "/Pic/greenballoon.png");
    yellowBalloonPic  = loadImage("./Themes/Theme" + themeNum + "/Pic/yellowballoon.png");
    pinkBalloonPic    = loadImage("./Themes/Theme" + themeNum + "/Pic/pinkballoon.png");
    rainbowBalloonPic = loadImage("./Themes/Theme" + themeNum + "/Pic/rainbowballoon.png");
  
    //towers' images
    dartMonkeyPic  = loadImage("./Themes/Theme" + themeNum + "/Pic/dart_monkey.png");
    iceTowerPic    = loadImage("./Themes/Theme" + themeNum + "/Pic/ice_tower.png");
    bombTowerPic   = loadImage("./Themes/Theme" + themeNum + "/Pic/bomb_tower.png");
    superMonkeyPic = loadImage("./Themes/Theme" + themeNum + "/Pic/super_monkey.png");
  
    //weapons' images
    dartPic  = loadImage("./Themes/Theme" + themeNum + "/Pic/dart.png");
    bombPic  = loadImage("./Themes/Theme" + themeNum + "/Pic/note7.png");
    laserPic = loadImage("./Themes/Theme" + themeNum + "/Pic/laser.png");
    
    //effects' images
    explosionPic = loadImage("./Themes/Theme" + themeNum + "/Pic/explosion.png");
    snowPic      = loadImage("./Themes/Theme" + themeNum + "/Pic/dart.png");
    
    //backgrounds' images
    for (int i=0; i<3; i++)
      map[i] = loadImage("./Themes/Theme" + themeNum + "/Pic/map" + str(i) + ".jpg");
    
    sellButtonPic = loadImage("./Themes/Theme" + themeNum + "/Pic/sell_button.png");
    startArrowPic = loadImage("./Themes/Theme" + themeNum + "/Pic/start_arrow.png");
      
    //-----------------------load fonts------------------------//
    fontSmall  = loadFont("./Themes/Theme" + themeNum + "/Font/font_small.vlw");
    fontMedium = loadFont("./Themes/Theme" + themeNum + "/Font/font_medium.vlw");
    fontLarge  = loadFont("./Themes/Theme" + themeNum + "/Font/font_large.vlw");
  
  
    //-----------------------load sounds-----------------------//
    bgSound    = minim.loadFile("./Themes/Theme" + themeNum + "/Sound/bg.mp3"); 
    dartSound  = minim.loadFile("./Themes/Theme" + themeNum + "/Sound/pop.mp3");
    bombSound  = minim.loadFile("./Themes/Theme" + themeNum + "/Sound/bomb.mp3");
    laserSound = minim.loadFile("./Themes/Theme" + themeNum + "/Sound/laser.mp3");
    iceSound   = minim.loadFile("./Themes/Theme" + themeNum + "/Sound/ice.mp3");
  }
}