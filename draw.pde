void draw() {
  background(screen.bg);
  playMusic();
  
  //only draw towers, balloons, ... when not pausing
  if (!pausing) {
    checkGameEnd();
    
    //only draw balloons and weapons when player have not finish round
    if (starting) {
      createBalloon();
      drawBalloons();
      drawWeapons();
      drawEffect();
      checkFinishRound();
    }
    
    drawTower();
  }
  
  showInfo();
  drawMouse();
}


//----------------------------play music-----------------------------------
void playMusic() {
  if (musicEnable) {
    if (!bgSound.isPlaying())
      bgSound.rewind();
    bgSound.play();
  } else { 
    bgSound.pause();
  }  
}


//-------------------check if player has won or lost yet-------------------
void checkGameEnd() {
  if (health<=0) {
    screen = loseScreen;    
    pausing = true;
  } 
  if (currentRound == (TOTAL_ROUNDS+1)) {
    screen = winScreen;
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
    int i = (int) random(1, 101);                        // random integer for choosing type of balloon to create                                           // number of balloons created

    // 100% red balloons when round <=2
    if (currentRound <= 5) {
      balloonList[createdBalloonInRound] = new RedBalloon();
      
    // 60% red, 40% blue
    } else if (currentRound <= 10) {
      if (i <= 60) {
        balloonList[createdBalloonInRound] = new RedBalloon();
      } else {
        balloonList[createdBalloonInRound] = new BlueBalloon();
      }
      
    // 25% red, 35% blue, 40% green 
    } else if (currentRound <= 15) {
      if (i <= 25) {
        balloonList[createdBalloonInRound] = new RedBalloon();
      } else if (i <= 60) {
        balloonList[createdBalloonInRound] = new BlueBalloon();
      } else {
        balloonList[createdBalloonInRound] = new GreenBalloon();
      }
    
    // 10% red, 20% blue, 30% green, 40% yellow 
    } else if (currentRound <= 20) {
      if (i <= 10) {
        balloonList[createdBalloonInRound] = new RedBalloon();
      } else if (i <= 30) {
        balloonList[createdBalloonInRound] = new BlueBalloon();
      } else if (i <= 60) {
        balloonList[createdBalloonInRound] = new GreenBalloon();
      } else {
        balloonList[createdBalloonInRound] = new YellowBalloon();
      }
      
    // 10% red, 15% blue, 20% green, 25% yellow, 30% pink
    } else if (currentRound <= 25) {
      if (i <= 10) {
        balloonList[createdBalloonInRound] = new RedBalloon();
      } else if (i <= 25) {
        balloonList[createdBalloonInRound] = new BlueBalloon();
      } else if (i <= 45) {
        balloonList[createdBalloonInRound] = new GreenBalloon();
      } else if (i <= 70) {
        balloonList[createdBalloonInRound] = new YellowBalloon();
      } else {
        balloonList[createdBalloonInRound] = new PinkBalloon();
      }
      
    // 0% red, 15% blue, 20% green, 25% yellow, 30% pink, 10% rainbow
    } else {
      if (i <= 10) {
        balloonList[createdBalloonInRound] = new RainbowBalloon();
      } else if (i <= 25) {
        balloonList[createdBalloonInRound] = new BlueBalloon();
      } else if (i <= 45) {
        balloonList[createdBalloonInRound] = new GreenBalloon();
      } else if (i <= 70) {
        balloonList[createdBalloonInRound] = new YellowBalloon();
      } else {
        balloonList[createdBalloonInRound] = new PinkBalloon();
      }
    }

    // increase number of created balloon in this round
    createdBalloonInRound++;  
  }
}


//--------------------draw and move balloons----------------------
void drawBalloons() {
  for (int i=0; i<createdBalloonInRound; i++) {
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

    //----check whether balloon has escaped-----
    if (balloonList[i].position > track.x.length-2) {
      health -= balloonList[i].health;
      balloonList[i].status = 1;
      popCount++;
    }
  }
}


//--------------------draw and move weapons----------------------
void drawWeapons() {
  for (int i=0; i<weaponNum; i++) {
    if (weaponList[i].status==0) {
      //move
      weaponList[i].x += weaponList[i].speedX;
      weaponList[i].y += weaponList[i].speedY;
      
      //draw
      image(weaponList[i].img, weaponList[i].x, weaponList[i].y);
      
      //check whether weapon hit any balloon
      weaponList[i].pop();
    }
  }
}


//------------------check if player has finished this round---------------------
void checkFinishRound () {
  if (createdBalloonInRound == totalBalloonInRound && popCount == createdBalloonInRound) {
    currentRound++;                                                    // increase round
    totalBalloonInRound = (int)(totalBalloonInRound * DIFFICULTY);     // increase number of balloon-to-be-created next round
    message = "Round " + str(currentRound - 1) + " completed!";        // show message
    messageTime = 75;                                                  // time of message
    
    popCount = 0;                                                      // reset popCount after each round
    createdBalloonInRound = 0;                                         // reset created balloon in round
    balloonList = new Balloon [BALLOON_LIST_SIZE];                     // reset balloonList
    weaponList  = new Weapon [WEAPON_LIST_SIZE];                       // reset weaponList
    weaponNum  = 0;                                                    // reset weapon counter
    effectNum  = 0;                                                    // reset effect counter
    
    starting = false;                                                  // let player build new tower before starting new round
    screen.buttonList[1].enable = true;                                // enable saving game
  }
}


//---------------------draw effects: freeze, explosion,...----------------
void drawEffect() {
  for (int i=0; i<effectNum; i++) {
    //skip finished effect
    if (effectList[i].status == 1)
      continue;
    effectList[i].show();
  }
}


//--------------------draw towers and shoot----------------------
void drawTower() {
  //------shoot------
  if (starting) 
    for (int i=0; i<towerList.length; i++)
      towerList[i].shoot();
  
  //-----draw tower-----
  for (int i=0; i<towerList.length; i++) {
    // draw a circle around chosen tower
    if (towerList[i] == chosenTower) {
      fill(WHITE);
      ellipse(towerList[i].x, towerList[i].y, towerList[i].shootRadius*2, towerList[i].shootRadius*2);
    }
      
    //draw tower
    translate(towerList[i].x, towerList[i].y);
    rotate(towerList[i].angle + PI/2);
    image(towerList[i].img, 0, 0);
    rotate(-towerList[i].angle - PI/2);
    translate(-towerList[i].x, -towerList[i].y);
  }
}


//------highlight buttons if mouse on them; draw building tower--------------
void drawMouse() {
  //-----check whether mouse on any button-----
  Button b;
  for (int i=0; i<screen.buttonList.length; i++) {
    b = screen.buttonList[i]; 
    if (b.containPoint(mouseX, mouseY) && b.enable) {
      // highlight the button
      fill(BLUE);
      rect(b.x1, b.y1, b.x2, b.y2);
      
      // print tower price if it's a create new tower button
      if (b instanceof NewTowerButton) {
        NewTowerButton bt = (NewTowerButton) b;
        fill(255,0,0);
        text("$" + str(bt.price), 720, 200);  
      }
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

    //check if the building tower touch other towers
    if (!buildingTowerConflict)
      for (int i=0; i<towerList.length; i++) {
        if (touch(buildingTower, towerList[i])) {
          buildingTowerConflict = true;
          break;
        }
      }

    //select color around building tower circle
    if (buildingTowerConflict)
      fill(RED);
    else 
      fill(WHITE);
    
    ellipse(mouseX, mouseY, buildingTower.shootRadius*2, buildingTower.shootRadius*2);       //draw circle around tower
    image(buildingTower.img, mouseX, mouseY);                                                //draw tower
  }
}


//--------------print health, money, messages on screen-------------//
void showInfo() {
  //-------print message-----------
  textFont(fontSmall);
  fill(255, 0, 0);
  if (messageTime != 0) {
    text(message,100, 480);
    messageTime--;
  }
  
  //---- in play screen------------
  if (screen == playScreen) {
    //print basic info
    text(money, 725, 20);
    text(health, 725, 45);
    text("Round " + str(currentRound), 700, 70);

    // show where the balloons start
    if (!starting)
      image(startArrowPic, track.x[5], track.y[5], 50, 50);

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

    // positions to print text
    float xScore0 = width/6;
    float xScore1 = width/2;
    float xScore2 = width*5/6;
    float yScore = height/3 + 100;

    // print scores
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