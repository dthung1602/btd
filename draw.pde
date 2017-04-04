void draw() {
  if (!pausing) {
    //if (gameEnd())
    //  return;

    background(screen.bg);
    fill(WHITE);

    // check if player has finished round
    if (createdRoundHealth > totalRoundHealth)
      starting = false;

    //only draw balloons and weapons when player has clicked start
    if (starting) {
      //createBallon();
      drawBalloons();
      drawWeapons();
    }

    drawTower();
    drawMouse();
    showInfo();
  } else {
    delay(CLICK_TIME);
  }
}


boolean gameEnd() {
  if (health<=0) {
    println("LOSE!");
    //>>> show score;
    //>>> ask play again or load last save game or main menu
    return true;
  } 
  if (currentRound == (totalRounds+1) && finishRound()) {
    println("WIN!");
    //>>> calculate score <<<
    //>>> if > highest score --> anouce <<<
    //>>> unlock next level
    //>>> let user choose
    return true;
  }
  return false;
}


void drawBalloons() {
  for (int i=0; i<balloonList.length; i++) {
    //---skip poped balloons----
    if (balloonList[i].status == 1) 
      continue;

    //---draw balloon----------
    image(balloonList[i].img, track.x[balloonList[i].position], track.y[balloonList[i].position], 50, 50); 

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


void drawWeapons() {
  for (int i=0; i<weaponList.length; i++) {
    if (weaponList[i].status==0) {
      weaponList[i].x += weaponList[i].speedX;
      weaponList[i].y += weaponList[i].speedY;
      image(weaponList[i].img, weaponList[i].x, weaponList[i].y, 20, 20);
      weaponList[i].pop();
    }
  }
}


void drawTower() {
  //-----draw tower-----
  for (int i=0; i<towerList.length; i++) {
    if (towerList[i] == chosenTower)
      ellipse(towerList[i].x, towerList[i].y, towerList[i].shootRadius*2, towerList[i].shootRadius*2);
    image(towerList[i].img, towerList[i].x, towerList[i].y, 50, 50);
  }

  //------shoot------
  if (starting) 
    for (int i=0; i<towerList.length; i++)
      towerList[i].shoot();
}


void drawMouse() {
  //--------------check mouse on any button---------------
  fill(WHITE);
  Button b;
  for (int i=0; i<screen.buttonList.length; i++) {
    b = screen.buttonList[i]; 
    if (b.containPoint(mouseX, mouseY)) {
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


void showInfo() {
  textFont(fontSmall);
  fill(255, 0, 0);
  text(money, 725, 20);
  text(health, 725, 45);
}


boolean finishRound () {
  //-----check if all balloons are cleared-----
  if ( popCount == createdRoundHealth ) {  
    totalRoundHealth = (int)(totalRoundHealth * difficultyLevel);     // increase level of difficulty after each round
    currentRound++;                                                   // increase round
    popCount = 0;                                                     // reset popCount after each round
    createdRoundHealth = 0;                                           // reset createdRoundHealth
    balloonList = new Balloon[] {};                                   // reset balloonList
    weaponList = new Weapon [] {};                                    // reset weaponList
    return true;
  }
  return false;
}


void createBallon () {     
  int i = (int)random(0, 100+1);                           // random integer for choosing type of balloon to create                                           // number of balloons created
  balloonDelay = (int) random(5, 25);                 // random number of frame till the next balloon's creation

  //--------create balloon based on random i-------
  if ((frameCount - oldFrame) == balloonDelay) {           // delay creating balloon
    oldFrame = frameCount;                                 // old frameCount

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
    } else if (currentRound <= 20)
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

  createdRoundHealth += balloonList[balloonNum].health;         // increase createdRoundHealth
  balloonNum++;                                                 // increase number of balloons
}