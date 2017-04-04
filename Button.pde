abstract class Button {
  float x1, y1;
  float x2, y2;
  
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
    // just example
    println("NEW game!");
    screen = playScreen;
    fill(255,255,0,100);
    //real action 
    pausing = false;
    starting = true;
  }
}

/*Vlong's job
*/
class SaveGameButton extends Button {
  //>>> save current game to file
  SaveGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    
  }
}


class LoadGameButton extends Button {
  //>>> load game from file 
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
  //>>> use exit function 


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
    frameRate(SLOW);             // default play slowly when start
    starting = true;
  } 
}


class FastForwardButton extends Button {
  //>>> increase frame rate to 50
  FastForwardButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }

  void action() {
   frameRate(FAST); 
  }
}


class SlowDownButton extends Button {
  //>>> reduce frame rate to 25
  SlowDownButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2){
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action(){
    frameRate(SLOW);
  }
}


class ResumeButton extends Button {
  //>> pausing = false
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


class MenuButton extends Button {  
  MenuButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }
  
  void action() {
    pausing = true;
    screen = menuScreen;
    fill(WHITE);
    background(screen.bg);
    rect(100,100,200,300);
    rect(200,100,300,300);
    fill(0,255,255,100);
  }
}


/*class PlayAgainButton extends Button {}
 when lose only
 reset health, towerList, ...
 starting = false
*/
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
    currentRound = 1;
  }
}