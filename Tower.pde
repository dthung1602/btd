abstract class Tower {
  float x, y;                  // coordinates of tower
  float shootRadius;           // how far tower can shoot
  float buildRadius;           // how much space tower takes
  PImage img;
  int price;
  int speed;                   // how fast the weapon of this tower travel
  float delay;                 // delay time between shots
  float angle = -PI/2;          // angle of rotation
  
  Tower (float x, float y, float shootRadius, float buildRadius, PImage image, int price) {
    this.x = x;
    this.y = y;
    this.shootRadius = shootRadius;
    this.buildRadius = buildRadius;
    this.img = image;
    this.price = price;
  }

  void shoot() {
    // save the position of the first balloon in shootRadius
    int max = -1;  

    //Check all the balloons in balloonList and find the balloon with the highest position
    for (int i=0; i < createdBalloonInRound; i++) {
      //skip popped balloons
      if (balloonList[i].status == 1)
        continue;
      if (touch(this, balloonList[i]) && balloonList[i].position > max)
        max = balloonList[i].position;
    }

    //if that highest position is -1 ===> There is no balloon
    if ( max == -1 )
      return;

    //1 weapon is created after delay frames pass 
    if ( frameCount % delay == 0 ) {
      float d = dist(track.x[max], track.y[max], x, y);            //distance from the tower cordinate to the track cordinate 

      float xSpeed = (track.x[max] - x) * speed / d;
      float ySpeed = (track.y[max] - y) * speed / d;

      weaponList[weaponNum] = newWeapon(x, y, xSpeed, ySpeed);     //create new weapon
      weaponNum++;
    }
    
    // rotate the tower
    angle = -atan2(y-track.y[max],track.x[max]-x);
  }
  
  private Weapon newWeapon(float x, float y, float xSpeed, float ySpeed) {
    if (this instanceof DartMonkey)
      return new Dart(x, y, xSpeed, ySpeed);
    if (this instanceof BombTower)
      return new Bomb(x, y, xSpeed, ySpeed);
    return new Laser(x, y, xSpeed, ySpeed);
  }
}


class DartMonkey extends Tower {
  DartMonkey(float x, float y) {
    super(x, y, 100, 20, dartMonkeyPic, 50);
    speed = 15;
    delay = 25;
  }
}


class IceTower extends Tower {
  int freezeTime = 60;
  
  IceTower(float x, float y) {
    super(x, y, 100, 20, iceTowerPic, 75);
    delay = 100;
  }

  void shoot() {
    // delay between shots
    if (frameCount % delay != 0)
      return;
    
    
    
    //freeze all balloons in shooting radius for freezeTime frames
    boolean hitTarget = false;
    for (int i=0; i < createdBalloonInRound; i++) {
      //skip popped balloons
      if (balloonList[i].status == 1)
        continue;
      if (touch(this, balloonList[i])) {
        balloonList[i].freeze = freezeTime;
        hitTarget = true;
      }
    }
    
    //create freezing effect
    if (hitTarget) {
      effectList[effectNum] = new FreezeEffect(x, y);
      effectNum++;
    }
  }
}


class BombTower extends Tower {
  BombTower(float x, float y) {
    super(x, y, 100, 27, bombTowerPic, 150);
    speed = 20;
    delay = 30;
  }
}


class SuperMonkey extends Tower {
  SuperMonkey(float x, float y) {
    super(x, y, 100, 20, superMonkeyPic, 250);
    speed = 25;
    delay = 7;
  }
}