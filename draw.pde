void draw() {
  background(screen.bg);
  
  //only draw towers, balloons, ... when not pausing
  if (!pausing) {
    //checkGameEnd();
    
    //only draw balloons and weapons when player have not finish round
    if (starting) {
      createBalloon();
      drawBalloons();
      drawWeapons();
      checkFinishRound();
    }

    drawTower();
  }
  
  showInfo();
  drawMouse();
}


//-------------------check if player has win or lost yet-------------------
void checkGameEnd() {
  if (health<=0) {
    screen = winScreen;    
    pausing = true;
  } 
  if (currentRound == (totalRounds+1)) {
    screen = loseScreen;
    pausing = true;
  }
}


//-------------------create new balloons-------------------
void createBalloon () {     
  // check if the program has created enough balloon for this round
  if (createdBalloonInRound == totalBalloonInRound)
    return;
  
  // only create new balloon after newBalloonDelay frames have pased
  if ((frameCount - oldFrame) == newBalloonDelay) {           
    oldFrame = frameCount;                                
    newBalloonDelay = (int) random(5, 25);               // random number of frame till the next balloon's creation
    int i = (int)random(0, 100+1);                       // random integer for choosing type of balloon to create                                           // number of balloons created

    if (currentRound <= 2) {
      balloonList[balloonNum] = new RedBalloon();
    } else if (currentRound <= 5) {
      if (i <= 40) {
        balloonList[balloonNum] = new RedBalloon();
      } else {
        balloonList[balloonNum] = new BlueBalloon();
      }
    } else if (currentRound <= 9) {
      if (i <= 25) {
        balloonList[balloonNum] = new RedBalloon();
      } else if (i <= 60) {
        balloonList[balloonNum] = new BlueBalloon();
      } else {
        balloonList[balloonNum] = new GreenBalloon();
      }
    } else if (currentRound <= 14) {
      if (i <= 10) {
        balloonList[balloonNum] = new RedBalloon();
      } else if (i <= 30) {
        balloonList[balloonNum] = new BlueBalloon();
      } else if (i <= 60) {
        balloonList[balloonNum] = new GreenBalloon();
      } else {
        balloonList[balloonNum] = new YellowBalloon();
      }
    } else if (currentRound <= 20) {
      if (i <= 10) {
        balloonList[balloonNum] = new RedBalloon();
      } else if (i <= 25) {
        balloonList[balloonNum] = new BlueBalloon();
      } else if (i <= 45) {
        balloonList[balloonNum] = new GreenBalloon();
      } else if (i <= 70) {
        balloonList[balloonNum] = new YellowBalloon();
      } else {
        balloonList[balloonNum] = new PinkBalloon();
      }
    } else {
      if (i <= 10) {
        balloonList[balloonNum] = new RainbowBalloon();
      } else if (i <= 25) {
        balloonList[balloonNum] = new BlueBalloon();
      } else if (i <= 45) {
        balloonList[balloonNum] = new GreenBalloon();
      } else if (i <= 70) {
        balloonList[balloonNum] = new YellowBalloon();
      } else {
        balloonList[balloonNum] = new PinkBalloon();
      }
    }

    createdBalloonInRound++;                                      // increase createdBalloonInRound
    balloonNum++;                                                 // increase number of balloons
  }
}


//--------------------draw and move balloons----------------------
void drawBalloons() {
  for (int i=0; i<balloonNum; i++) {
    //---skip poped balloons----
    if (balloonList[i].status == 1) 
      continue;

    //---draw balloon----------
    image(balloonList[i].img, track.x[balloonList[i].position], track.y[balloonList[i].position]); 

    //---freeze balloon--------
    if (balloonList[i].freeze > 0) {
      balloonList[i].freeze -= 1;
      continue;
    }

    //-----move balloons-------
    balloonList[i].position += balloonList[i].speed;

    //----check if balloon escape-----
    if (balloonList[i].position > track.x.length-2) {
      health -= balloonList[i].health;
      balloonList[i].status = 1;
    }
  }
}


//--------------------draw and move weapons----------------------
void drawWeapons() {
  for (int i=0; i<weaponNum; i++) {
    if (weaponList[i].status==0) {
      weaponList[i].x += weaponList[i].speedX;
      weaponList[i].y += weaponList[i].speedY;
      image(weaponList[i].img, weaponList[i].x, weaponList[i].y);
      weaponList[i].pop();
    }
  }
}


//------------------check if player has finished this round---------------------
void checkFinishRound () {
  if ( createdBalloonInRound == totalBalloonInRound && popCount == createdBalloonInRound ) {  
    totalBalloonInRound = (int)(totalBalloonInRound * difficultyLevel);     // increase level of difficulty after each round
    currentRound++;                                                   // increase round
    popCount = 0;                                                     // reset popCount after each round
    createdBalloonInRound = 0;                                           // reset createdBalloonInRound
    balloonList = new Balloon [BALLOON_LIST_SIZE];                                   // reset balloonList
    weaponList  = new Weapon [WEAPON_LIST_SIZE];                                    // reset weaponList
    starting = false;
    balloonNum = 0;
    weaponNum  = 0;
    screen.buttonList[1].enable = true;
  }
}


//--------------------draw towers and shoot----------------------
void drawTower() {
  //-----draw tower-----
  fill(WHITE);
  for (int i=0; i<towerList.length; i++) {
    if (towerList[i] == chosenTower)
      ellipse(towerList[i].x, towerList[i].y, towerList[i].shootRadius*2, towerList[i].shootRadius*2);
    image(towerList[i].img, towerList[i].x, towerList[i].y);
  }

  //------shoot------
  if (starting) 
    for (int i=0; i<towerList.length; i++)
      towerList[i].shoot();
}


//------highlight buttons if mouse on them; draw building tower--------------
void drawMouse() {
  //-----check if mouse on any button-----
  fill(BLUE);
  Button b;
  for (int i=0; i<screen.buttonList.length; i++) {
    b = screen.buttonList[i]; 
    if (b.containPoint(mouseX, mouseY) && b.enable) {
      rect(b.x1, b.y1, b.x2, b.y2);
      return;
    }
  }

  //--------draw building tower---------
  if (buildingTower != null) {
    buildingTowerConflict = false;
    buildingTower.x = mouseX;
    buildingTower.y = mouseY;

    //check if tower touch the road 
    for (int i=0; i<track.x.length; i++)
      if (touch(buildingTower, track.x[i], track.y[i])) {
        buildingTowerConflict = true;
        break;
      }

    //check if the building tower touch the others
    if (!buildingTowerConflict)
      for (int i=0; i<towerList.length; i++) {
        if (touch(buildingTower, towerList[i])) {
          buildingTowerConflict = true;
          break;
        }
      }

    //select building tower color circle
    if (buildingTowerConflict)
      fill(RED);
    else 
      fill(WHITE);

    //draw tower
    ellipse(mouseX, mouseY, buildingTower.shootRadius*2, buildingTower.shootRadius*2);
    image(buildingTower.img, mouseX, mouseY, 50, 50);
  }
}


//--------------print health, money, messages on screen-------------//
void showInfo() {
  //---- in play screen------------
  if (screen == playScreen) {
    textFont(fontSmall);
    fill(255, 0, 0);
    
    //print basic info
    text(money, 725, 20);
    text(health, 725, 45);
    text("Round " + str(currentRound), 700, 70);

    //print message
    if (messageTime != 0) {
      text(message,100, 480);
      messageTime--;
    }

    //draw sell button
    if (chosenTower != null) {
      screen.buttonList[0].enable = true;
      image(sellButtonPic, 750, 340, 60, 60);
    } else {
      screen.buttonList[0].enable = false;
    }
    return;
  }
  
  //---------in highscore screen-------------
  if (screen == highScoreScreen) {
    fill(255, 0, 0);
    textFont(fontMedium);
    text("Track 1", width/6-50, 235);
    text("Track 2", width/2-50, 235);
    text("Track 3", width*5/6-50, 235);

    float xScore0 = width/6;
    float xScore1 = width/2;
    float xScore2 = width*5/6;
    float yScore = height/3 + 100;

    fill(250, 255, 0);
    textFont(fontSmall);
    for (int i = 0; i < 5; i++) {
      text(highscore[0][i], xScore0, yScore);
      text(highscore[1][i], xScore1, yScore);
      text(highscore[2][i], xScore2, yScore);
      yScore = yScore + 30;
    }

    if (achievedHighscore) {
      fill(0, 255, 0);
      textFont(fontMedium);
      text("Congratulation! You've achieved highscore <3<3", 50, height*4/5+50);
    }
  }
}