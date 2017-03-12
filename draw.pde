void draw() {
  if (!pausing) {
    //--------------check win,lose-------------//
    if (game.health<=0)
      lose();
    else if (game.baloonCount==0)
      win();
    
    //-------------draw background-------------//
    background(screen.bg);
    fill(WHITE);
    
    //-------draw weapons & calculate---------//
    if (starting) {
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
    int l = tw.length;
    for (int i=0; i<l; i++) {
      if (tw[i] == game.chosenTower)
        ellipse(tw[i].x, tw[i].y, tw[i].shootRadius*2, tw[i].shootRadius*2);
      image(tw[i].img, tw[i].x, tw[i].y);
      tw[i].shoot();
    }
    
    //-------------draw mouse------------------//
    //draw building tower
    if (game.chosenTower != null) {
      for (int i=0; i<l; i++) {
        if (touch(game.buildingTower,tw[i]) {
          fill(RED);
          ellipse(mouseX, mouseY, game.buildingTower.shootRadius*2, game.buildingTower.shootRadius*2);
          break;
        }
      }
    }
    
    //check buttons
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