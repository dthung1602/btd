abstract class Button {
  float x1, y1;
  float x2, y2;
  boolean enable = true;

  Button(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    x1 = tmp_x1;
    y1 = tmp_y1;
    x2 = tmp_x2;
    y2 = tmp_y2;
  }
  
  boolean containPoint(float x, float y) {
    if (x1<=x && x<x2 && y1<y && y<y2)
      return true;
    return false;
  }
  
  void action() {}
}


// -----------------menu buttons---------------------
class NewGameButton extends Button {
  NewGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action() {  
    screen = choosingTrackScreen;
  }
}

/* Vlong's job */

class SaveGameButton extends Button {
  SaveGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    
  }
}


class LoadGameButton extends Button {
  LoadGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }

  void action(){
    
  }
}


class HighScoreButton extends Button {
  HighScoreButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    
  }
}


class QuitButton extends Button {
  QuitButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1,tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    exit();
  }
}


//--------------create & sell towers-----------------
class NewDartMonkey extends Button {
  NewDartMonkey (float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }
  
  void action() {
    //cancel buying
    if (buildingTower instanceof DartMonkey) {
      buildingTower = null;
      return;
    }
    
    //new tower
    chosenTower = null;
    buildingTower = new DartMonkey(mouseX, mouseY);
    if (money < buildingTower.price) 
      buildingTower = null;
  }
}


class NewBombTower extends Button {
  NewBombTower (float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }
  
  void action() {
    //cancel buying
    if (buildingTower instanceof BombTower) {
      buildingTower = null;
      return;
    }
    
    //new tower
    chosenTower = null;
    buildingTower = new BombTower(mouseX, mouseY);
    if (money < buildingTower.price) 
      buildingTower = null;
  }
}


class NewSuperMonkey extends Button {
  NewSuperMonkey (float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }
  
  void action() {
    //cancel buying
    if (buildingTower instanceof SuperMonkey) {
      buildingTower = null;
      return;
    }
    
    //new tower
    chosenTower = null;
    buildingTower = new SuperMonkey(mouseX, mouseY);
    if (money < buildingTower.price) 
      buildingTower = null;
  }
}


class NewIceTower extends Button {
  NewIceTower (float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }
  
  void action() {
    //cancel buying
    if (buildingTower instanceof IceTower) {
      buildingTower = null;
      return;
    }
    
    //new tower
    chosenTower = null;
    buildingTower = new IceTower(mouseX, mouseY);
    if (money < buildingTower.price) 
      buildingTower = null;
  }
}


class SellButton extends Button {
  SellButton (float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }
  
  void action() {
    if (chosenTower != null) {
      for (int i=0; i<towerList.length; i++)
        if (towerList[i] == chosenTower) {
          towerList = (Tower []) concat(subset(towerList, 0, i), subset(towerList, i+1));
          money += (int) chosenTower.price*SELL_PERCENT;
          chosenTower = null;
          return;
        }
    }
  }
}


//------------------game control buttons---------------------
class StartButton extends Button {  
  StartButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action() {
    frameRate(SLOW);                // default play slowly when start
    starting = true;
    oldFrame = frameCount;    
  } 
}


class FastOrSlowButton extends Button {
  FastOrSlowButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }

  void action() {
    if (starting) {
      if (frameRate == FAST) {
        frameRate(SLOW);
      } else {
        frameRate(FAST);
      }
    } else {
      frameRate(SLOW);                // default play slowly when start
      starting = true;
      oldFrame = frameCount;
    }
  }
}


class MenuButton extends Button {  
  MenuButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action() {
    pausing = true;
    screen = menuScreen;
  }
}


//------------Choosing track Button-------------

class Track1Button extends Button {
  Track1Button(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    screen = playScreen;
    pausing = false;
    starting = false;
    //load track from file
  }
}


class Track2Button extends Button {
  Track2Button(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    screen = playScreen;
    pausing = false;
    starting = false;
    //load track from file
  }
}


class Track3Button extends Button {
  Track3Button(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    screen = playScreen;
    pausing = false;
    starting = false;
    //load track from file
  }
}




/*------------------------ temporary disable-------------------------------
class ResumeButton extends Button {
  ResumeButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    pausing = false;
    screen = playScreen;
  } 
}


class PauseButton extends Button {
  PauseButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    pausing = !pausing;
  }
}


class PlayAgainButton extends Button {
  PlayAgainButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
   super(tmp_x1, tmp_y1, tmp_x2, tmp_y2); 
  }
  
  void action() {
    pausing = false;
    screen = playScreen;
    //reset health, towerlist, weaponlist
    towerList = new Tower[0];
    weaponList = new Weapon[0];
    health = track.defaultHealth;
    money = track.defaultMoney;
    track.round = 1;
  }
}

*/