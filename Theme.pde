class Theme {
  int themeNum;
  
  Theme (int num) {
    this.themeNum = num;
    reset();
    load();
    createScreen();
  }
  
  private void load () {
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
    bombPic  = loadImage("./Themes/Theme" + themeNum + "/Pic/bomb.png");
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
  
  private void reset () {
    if (frameCount > 1)
      bgSound.close();
  }
  
  private void createScreen () {
    PImage bg;
    Button buttonList [];
  
    //---------create menu screen-----------
    bg = loadImage("./Themes/Theme" + themeNum + "/Pic/menu.jpg");
    buttonList = new Button[] {
      new NewGameButton(15, 440, 250, 480), 
      new QuitButton(730, 10, 790, 70),
      new LoadGameButton(280, 440, 515, 480),
      new HighScoreButton(555, 440, 785, 480),
      new SettingButton(12, 12, 33, 33),
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
    bg = loadImage("./Themes/Theme" + themeNum + "/Pic/tracks.jpg");
    buttonList = new Button[] {
      new ChooseTrackButton(85, 135, 285, 275, 0),
      new ChooseTrackButton(290, 125, 495, 285, 1),
      new ChooseTrackButton(500, 140, 710, 290, 2),
      new MenuButton(655, 55, 695, 110)
    };
    choosingTrackScreen = new Screen(bg, buttonList);
  
    //---------create win screen-------------
    bg = loadImage("./Themes/Theme" + themeNum + "/Pic/win.jpg");
    buttonList = new Button[] {
      new MenuButton(415, 310, 495, 370)
    };
    winScreen = new Screen(bg, buttonList);
  
    //-----------create lose screen-------------
    bg = loadImage("./Themes/Theme" + themeNum + "/Pic/lose.jpg");
    buttonList = new Button[] {
      new MenuButton(580, 215, 655, 280),
    };
    loseScreen = new Screen(bg, buttonList);
  
    //-----------create high score screen-------------  
    bg = loadImage("./Themes/Theme" + themeNum + "/Pic/highscore.jpg");
    buttonList = new Button[] {
      new MenuButton(750, 475, 790, 512)
    };
    highScoreScreen = new Screen(bg, buttonList);
  
    //-----------create setting screen-------------
    bg = loadImage("./Themes/Theme" + themeNum + "/Pic/setting.jpg");
    buttonList = new Button[] {
      new ThemeButton(80, 175, 200, 275, 0),
      new ThemeButton(247, 178, 347, 277, 1),
      new MenuButton(345, 457, 375, 486),
      new MusicButton(375, 460, 405, 490),
      new SoundButton(405, 465, 435, 490),   
    };
    settingScreen = new Screen (bg, buttonList);
  }
}