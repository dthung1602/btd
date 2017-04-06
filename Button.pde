abstract class Button {
  float x1, y1;                      // upper left corner
  float x2, y2;                      // lower right corner
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


class SaveGameButton extends Button {
  SaveGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }

  void action() {
    String[] data = new String [ 9 + towerList.length];
    data[0] =str(popCount);
    data[1] =str(health);
    data[2] =str(money);
    data[3] =str(totalBalloonInRound);
    data[4] =str(createdBalloonInRound);
    data[5] =str(totalRounds);
    data[6] =str(currentRound);
    data[7] =str(difficultyLevel);
    data[8] =str(oldFrame);

    for (int i=0; i<towerList.length; i++) {
      data[i+9] = towerType(towerList[i]) + " " +str(towerList[i].x) + " " +str(towerList[i].y);
    }

    saveStrings("./Data/savedgame.txt", data);
  }

  private String towerType (Tower tw) {
    if (tw instanceof DartMonkey)
      return "0";
    if (tw instanceof IceTower)
      return "1";
    if (tw instanceof BombTower)
      return "2";
    return "3";
  }
}


class LoadGameButton extends Button {
  LoadGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }

  void action() {
    String[] data = loadStrings("./Data/savedgame.txt");
    popCount = int (data[0]);
    health = int (data[1]);
    money = int (data[2]);
    totalBalloonInRound = int (data[3]);
    createdBalloonInRound = int (data[4]);
    totalRounds = int (data[5]);
    currentRound = int (data[6]);
    difficultyLevel = int (data[7]);
    oldFrame = int (data[8]);

    int j=0;
    for (int i=0; i<data.length-9; i++) {
      float x = float(split(data[i], " ")[1]);
      float y = float(split(data[i], " ")[2]);
      int type = int(split(data[i], " ")[0]);
      switch (type) {
      case 0:
        towerList[j] = new DartMonkey(x, y);
        j++;
        break;
      case 1:
        towerList[j] = new IceTower(x, y);
        j++;
        break;
      case 2:
        towerList[j] = new BombTower(x, y);
        j++;
        break;
      case 3:
        towerList[j] = new SuperMonkey(x, y);
        j++;
      }
    }
  }
}


class HighScoreButton extends Button {
  HighScoreButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }

  void action() {
    //load data from file
    String data [] = loadStrings("./Data/highscore.txt");

    //convert data into a table of integer; 3 = number of track; 5 = number of highscores in a track
    highscore = new int [3][5];    
    int k=0;
    for (int i=0; i<3; i++)
      for (int j=0; j<5; j++) {
        highscore[i][j] = int(data[k]);
        k++;
      }

    //update highscore
    highscore[track.trackNum] = (int []) append(highscore[track.trackNum], currentRound); //add current round to array
    highscore[track.trackNum] = reverse(sort(highscore[track.trackNum]));                 //sort

    //check if player achieved highscore   
    if (highscore[track.trackNum][4] <= currentRound) 
      achievedHighscore = true;   

    //change screen
    pausing = true;
    screen = highScoreScreen;
  }
}


class QuitButton extends Button {
  QuitButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
  }

  void action() {
    exit();
  }
}


//--------------create & sell towers-----------------
class NewDartMonkey extends Button {
  NewDartMonkey (float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }

  void action() {
    println("dart monkey");
    
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
    println("bomb monkey");
    
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
    println("s monkey");
    
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
    println("eis monkey");
    
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

class ChooseTrackButton extends Button {
  int trackNum;
  
  ChooseTrackButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2, int num) {
    super(tmp_x1, tmp_y1, tmp_x2, tmp_y2);
    trackNum = num;
  }

  void action() {
    //change screen 
    pausing = false;
    starting = false;
    track = new Track(trackNum);
    screen = playScreen;
    screen.bg = map[trackNum];
    
    //initialize values
    balloonList = new Balloon [BALLOON_LIST_SIZE];
    weaponList  = new Weapon [WEAPON_LIST_SIZE];
    
    totalBalloonInRound = 10;
    createdBalloonInRound = 0;
    popCount = 0;
    
    health = track.defaultHealth;
    money = track.defaultMoney;
    currentRound = 1;
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