abstract class Button {
  float x1,y1;
  float x2,y2;
  
  Button(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    x1 = tmp_x1;
    y1 = tmp_y1;
    x2 = tmp_x2;
    y2 = tmp_y2;
  }
  
  boolean containPoint(float X, float Y) {
    if (x1<=X && X<x2 && y1<Y && Y<y2)
      return true;
    return false;
  }
  
  void action() {}
}


// test class
class GoButton extends Button {
  PImage img;
  
  GoButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    println("Go Go Go");
    pausing = true;
    screen = menuScreen;
    background(screen.bg);
  }
}


// -----------------menu buttons---------------------
class NewGameButton extends Button {
  PImage img;/**/
  
  NewGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    println("NEW game!");
    screen = playScreen;
    fill(255,255,0,100);
    pausing = false;
    starting = true;
  }
}

/*
class SaveGameButton extends Button {
  //>>> save current game to file
}

class LoadGameButton extends Button {
  //>>> load game from file 
}

class HighScoreButton extends Button {}

class QuitButton extends Button {}
*/

//--------------create & sell towers-----------------
class NewDarkMonkey extends Button {
  NewDarkMonkey (float x1, float y1, float x2, float y2) {
    super(x1,y1,x2,y2);
  }
  
  void action() {
    //>>> if not building  and if enough money <<<
    buildingTower = new DartMonkey(mouseX,mouseY);
    chosenTower = null;
    //>>> else cancel building
    //buildingTower = null; <<<<
  }
}


class SellButton extends Button {
  SellButton (float x1, float y1, float x2, float y2) {
    super(x1,y1,x2,y2);
  }
  
  void action() {
    if (chosenTower != null) {
      for (int i=0; i<towerList.length; i++)
        if (towerList[i] == chosenTower) {
          towerList = (Tower []) concat(subset(towerList,0,i),subset(towerList,i+1));
          money +=  (int) chosenTower.price * SELL_PERCENT;
          return;
        }
    }
  }
}


//------------------game control buttons---------------------
class StartButton extends Button {
  PImage img;/**/
  
  StartButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    println("Play button");
    frameRate(40); // default play slowly when start
    starting = true;
  } 
}
/*
class PauseButton extends Button {}

class ResumeButton extends Button {}
*/
class MenuButton extends Button {
  PImage img;
  
  MenuButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    println("Menu");
    pausing = true;
    screen = menuScreen;
    fill(WHITE);
    background(screen.bg);
    rect(100,100,200,300);
    rect(200,100,300,300);
    fill(0,255,255,100);
  }
}
/*
class FastForwardButton extends Button {
  //>>> increase frame rate 
}

class SlowDownButton extends Button {
  //>>> reduce frame rate
}

class PlayAgainButton extends Button {}
// when lose only*/