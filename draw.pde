void draw () {
  if (!pausing) {
    //--------------check win,lose-------------//
    if (game.health<=0) {
      lose();
      return;
    } else if (game.balloonCount==0) {
      win();
      return;
    }
     
    //>>> check if player has finished round
    // yes: starting = false;
    
    //-------------draw background-------------//
    background(screen.bg);
    fill(WHITE);
    int l;
    
    //>>>> null<<<<
    // only draw balloons and weapons when player has clicked start
    if (starting) {
      //--------------draw balloons & calculate---------------//
      Balloon bl [] = game.balloonList;
      l = bl.length;
      for (int i=0; i<l; i++) {
        //---skip poped balloons----
        if (bl[i].status == 2) 
          continue;
        
        //  ---calculate pos-----
        if (bl[i].stepInLine != 0 ) {
          //balloon still in old line, keep moving
          bl[i].x += bl[i].xSpeed;
          bl[i].y += bl[i].ySpeed;
          bl[i].stepInLine--;
        } else {
          //balloon in new line, change line, calculate new speed, calculate new step needed to finish line
          bl[i].line += 1;
          if (bl[i].status==0) bl[i].status = 1;
          if (bl[i].line == track.x.length) {
            game.health -= bl[i].health;
            bl[i].status = 2;
          } else {
            bl[i].xSpeed = bl[i].speed * track.xSpeed[bl[i].line];
            bl[i].ySpeed = bl[i].speed * track.ySpeed[bl[i].line];
            //step = distance / length of each step; distance of curent pos and next node in track; length of step is speed xy
            bl[i].stepInLine = (int) abs( distance(bl[i].x,bl[i].y,track.x[bl[i].line],track.y[bl[i].line]) / sqrt( sqr(track.xSpeed[bl[i].line] * bl[i].speed) + sqr(track.ySpeed[bl[i].line] * bl[i].speed) ) );
          }
        }
        //---draw balloons-----
        if (bl[i].status == 0) 
          continue; // do not draw balloon not yet in game
        image(bl[i].img,bl[i].x,bl[i].y,50,50);
      }
    
      //-------draw weapons & calculate---------//  
      Weapon wp [] = game.weaponList;
      l = wp.length;
      for (int i=0; i<l; i++) {
        wp[i].x += wp[i].speedX;
        wp[i].y += wp[i].speedY;
        image(wp[i].img, wp[i].x, wp[i].y);
        wp[i].pop();
      }
    }
    
    //------------draw towers & calculate-----------//
    Tower tw []= game.towerList;
    l = tw.length;
    for (int i=0; i<l; i++) {
      if (tw[i] == game.chosenTower)
        ellipse(tw[i].x, tw[i].y, tw[i].shootRadius*2, tw[i].shootRadius*2);
      image(tw[i].img, tw[i].x, tw[i].y, 100, 100);
      if (starting) 
        tw[i].shoot(i);
    }
    
    //-------------draw mouse------------------//
    //draw building tower
    //check if building tower touch the balloon's path
    //>>>> check if tower touch the road <<<
    if (game.buildingTower != null) {
      for (int i=0; i<l; i++) {
        //>>> optimize <<<
        game.buildingTowerConflict = false;
        game.buildingTower.x = mouseX;
        game.buildingTower.y = mouseY;
        if (touch(game.buildingTower,tw[i])) {
          game.buildingTowerConflict = true;
          break;
        }
      }
      //the building tower color circle
      if (game.buildingTowerConflict)
        fill(RED);
      else 
        fill(WHITE);
      ellipse(mouseX, mouseY, game.buildingTower.shootRadius*2, game.buildingTower.shootRadius*2);
      //draw tower
      image(game.buildingTower.img, mouseX, mouseY,100,100);
    }
    
    //check mouse on any button
    fill(WHITE);
    Button b;
    for (int i=0; i<screen.buttonList.length; i++) {
      b = screen.buttonList[i]; 
      if (b.containPoint(mouseX,mouseY))
        rect(b.x1,b.y1,b.x2,b.y2);
    }
    
  } else {
    delay(CLICK_TIME);
  }
}