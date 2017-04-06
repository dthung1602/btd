void mousePressed() {
  //check if any button is pressed
  for (int i=0; i<screen.buttonList.length; i++)
    if (screen.buttonList[i].containPoint(mouseX,mouseY) && screen.buttonList[i].enable) {
      screen.buttonList[i].action();
      return;
    }
    
  if (buildingTower == null) {
    //check if player selects any tower
    for (int i=0; i<towerList.length; i++)
      if (distance(mouseX,mouseY,towerList[i].x,towerList[i].y) <= towerList[i].buildRadius) {
        chosenTower = towerList[i];
        return;
      }
    chosenTower = null;
  } else {
    //build new tower
    if (!buildingTowerConflict) {
      towerList = (Tower []) append(towerList, buildingTower);
      money -= buildingTower.price;
      buildingTower = null;
    }
  } 
}