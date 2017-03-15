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
    
  if (buildingTower == null) {
    //check if player selects tower
    Tower tw []= towerList;
    l = tw.length;
    for (int i=0; i<l; i++)
      if (distance(mouseX,mouseY,tw[i].x,tw[i].y) <= tw[i].buildRadius) {
        chosenTower = tw[i];
        return;
      }
    chosenTower = null;
    return;
  } else {
    //check if player builds tower
    if (!buildingTowerConflict) {
      towerList = (Tower []) append(towerList, buildingTower);
      money -= buildingTower.price;
      buildingTower = null;
    }
  } 
}