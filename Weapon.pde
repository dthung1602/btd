abstract class Weapon {
  float x, y;
  float speedX, speedY;
  float popRadius;
  float explodeRadius;
  int damage;                     // damage cause to balloon 
  int status;                     // 0 = still in game; 1 = popped balloon and out of game 
  PImage img;
  
  Weapon (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    x = tmp_x;
    y = tmp_y;
    speedX = tmp_speedX;
    speedY = tmp_speedY;
    status = 0;
  }
  
  void pop() {
    for (int i = 0; i<balloonNum; i++) {
      if (balloonList[i].status == 1)
        continue;
      if (touch(this, balloonList[i])) {  //check if weapon touch balloon
        balloonList[i].health -= damage;
        if (balloonList[i].health <= 0) {   //check balloon health    
          balloonList[i].status = 1;
          popCount++;
          money += balloonList[i].moneyBonus;
        }
        status = 1;
        return;
      }
    }
  }
}


//---dart bullet---------
class Dart extends Weapon{    
  Dart (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    super(tmp_x, tmp_y, tmp_speedX, tmp_speedY);
    damage = 1;
    popRadius = 30;
    img = dartPic;
  }
}


//---bomb bullet---------
class Bomb extends Weapon{
  Bomb (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    super(tmp_x, tmp_y, tmp_speedX, tmp_speedY);
    damage = 2;
    popRadius = 40;
    img = bombPic;
    explodeRadius = 80;
  }
  
  void pop() {
    for (int i = 0; i<balloonNum; i++) {
      if (balloonList[i].status == 0 && touch(this, balloonList[i])) {
        status = 1;
        //--------------explode---------------------
        for (int j = 0; j<balloonNum; j++) {
          if (balloonList[j].status == 1)
            continue;
          if (touchEx(this, balloonList[j])) 
            balloonList[j].health -= damage;
          if (balloonList[j].health <= 0) {
            balloonList[j].status = 1;
            popCount++;
            money += balloonList[j].moneyBonus;
          }
        }
      }
    }
  }
}


//---laser bullet---------
class Laser extends Weapon{
  Laser (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    super(tmp_x, tmp_y, tmp_speedX, tmp_speedY);
    damage = 3;
    popRadius = 40;
    img = laserPic;
  }
}