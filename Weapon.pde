abstract class Weapon {
  float x, y;
  float speedX, speedY;
  float popRadius;                // if balloon is closer than popRadius, it is popped
  int damage;                     // damage cause to balloons
  int status;                     // 0 = still in game; 1 = popped balloon and out of game 
  PImage img;
  
  Weapon (float x, float y, float speedX, float speedY) {
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
    this.status = 0;
  }
  
  void pop() {
    for (int i = 0; i<createdBalloonInRound; i++) {
      if (balloonList[i].status == 1)        //skip popped balloons
        continue;
        
      if (touch(this, balloonList[i])) {     //check if weapon touch balloon
        balloonList[i].health -= damage;     //balloon receive damage
        if (balloonList[i].health <= 0) {    //check whether balloon still in game    
          balloonList[i].status = 1;
          popCount++;
          money += balloonList[i].moneyBonus;
        }
        status = 1;                          //weapon disappear
        return;
      }
    }
  }
}


//---dart bullet---------
class Dart extends Weapon{    
  Dart (float x, float y, float speedX, float speedY) {
    super(x, y, speedX, speedY);
    damage = 1;
    popRadius = 30;
    img = dartPic;
  }
}


//---bomb bullet---------
class Bomb extends Weapon{
  float explodeRadius = 60;      // all balloons in this radius when bomb hit taget will receive damage
  
  Bomb (float x, float y, float speedX, float speedY) {
    super(x, y, speedX, speedY);
    damage = 2;
    popRadius = 30;
    img = bombPic;
  }
  
  void pop() {
    for (int i = 0; i<createdBalloonInRound; i++) {
      if (balloonList[i].status == 0 && touch(this, balloonList[i])) {        
        // show explosion image
        effectList[effectNum] = new ExplosionEffect(x, y);
        effectNum++;
        
        // pop surrounding balloons
        for (int j = 0; j<createdBalloonInRound; j++) {
          if (balloonList[j].status == 1)      // skip popped balloons
            continue;
          if (touchEx(this, balloonList[j])) 
            balloonList[j].health -= damage;
          if (balloonList[j].health <= 0) {
            balloonList[j].status = 1;
            popCount++;
            money += balloonList[j].moneyBonus;
          }
        }
        
        //stop checking other balloons
        status = 1;
        return;
      }
    }
  }
}


//---laser bullet---------
class Laser extends Weapon{
  Laser (float x, float y, float speedX, float speedY) {
    super(x, y, speedX, speedY);
    damage = 3;
    popRadius = 40;
    img = laserPic;
  }
}