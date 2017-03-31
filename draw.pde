void draw() {
  if (!pausing) {
    //if (gameEnd())
    //  return;
    
    background(screen.bg);
    fill(WHITE);
    
    //>>> check if player has finished round
    // yes: starting = false;
    //>>>> null<<<<

    //only draw balloons and weapons when player has clicked start
    if (starting) {
      drawBalloons();
      drawWeapons();
    }

    drawTower();
    drawMouse();
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
  if (balloonCount==0) {
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
    if (balloonList[i].status == 2) 
      continue;        

    //-----move balloons-------
    balloonList[i].position += balloonList[i].speed;

    //-----check if balloon in game-----
    if (balloonList[i].status == 0)
      balloonList[i].status = 1;

    //----check if balloon escape-----
    if (balloonList[i].position >= track.x.length) {
      health -= balloonList[i].health;
      balloonList[i].status = 2;
      continue;
    }

    image(balloonList[i].img, track.x[balloonList[i].position], track.y[balloonList[i].position], 50, 50);
  }
}


void drawWeapons() {
  for (int i=0; i<weaponList.length; i++) {
    if (weaponList[i].status==0) {
      weaponList[i].x += weaponList[i].speedX;
      weaponList[i].y += weaponList[i].speedY;
      weaponList[i].pop(); //>>skip draw if poped balloon;
      image(weaponList[i].img, weaponList[i].x, weaponList[i].y);
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
      towerList[i].shoot(i);
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
      if (touch(buildingTower,track.x[i],track.y[i])) {
        buildingTowerConflict = true;
        break;
      }
    
    //check if the building tower touch the others
    if (!buildingTowerConflict)
      for (int i=0; i<towerList.length; i++) {
        if (touch(buildingTower,towerList[i])) {
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