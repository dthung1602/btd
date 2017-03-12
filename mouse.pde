/*buttons, towers do not overlap*/

void mousePressed() {
  //check if button is pressed
  Button bt [] = screen.buttonList;
  int l = bt.length;
  for (int i=0; i<l; i++)
    if (bt[i].containPoint(mouseX,mouseY)) {
      bt[i].action();
      return;
    }
    
  if (game.buildingTower == null) {
    //check if player selects tower
    Tower tw []= game.towerList;
    l = tw.length;
    for (int i=0; i<l; i++)
      if (distance(mouseX,mouseY,tw[i].x,tw[i].y <= tw.buildRadius) {
        game.chosenTower = tw[i];
        return;
      }
    game.chosenTower = null;
    return;
  } else {
    //check if player builds tower
    if (!game.buildingTowerConflict) {
      append(game.towerList, game.buildingTower);
      game.money -= game.buildingTower.price;
      game.buildingTower = null;
    }
  } 
}