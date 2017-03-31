void mousePressed() {
  //check if any button is pressed
  Button bt [] = screen.buttonList;
  int l = bt.length;
  for (int i=0; i<l; i++)
    if (bt[i].containPoint(mouseX,mouseY)) {
      bt[i].action();
      return;
    }
    
  if (buildingTower == null) {
    //check if player selects tower
    l = towerList.length;
    for (int i=0; i<l; i++)
      if (distance(mouseX,mouseY,towerList[i].x,towerList[i].y) <= towerList[i].buildRadius) {
        chosenTower = towerList[i];
        return;
      }
    chosenTower = null;
  } else {
    //check if player builds tower
    if (!buildingTowerConflict) {
      towerList = (Tower []) append(towerList, buildingTower);
      money -= buildingTower.price;
      buildingTower = null;
    }
  } 
}