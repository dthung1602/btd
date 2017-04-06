abstract class Tower {
  float x, y;
  float shootRadius;
  float buildRadius;
  PImage img;
  int price;
  int speed;
  float delay ;                // delay time between shots
  Tower (float tmp_x, float tmp_y, float tmp_shootRadius, float tmp_buildRadius, PImage tmp_image, int tmp_price) {
    x = tmp_x;
    y = tmp_y;
    shootRadius = tmp_shootRadius;
    buildRadius = tmp_buildRadius;
    img = tmp_image;
    price = tmp_price;
  }

  void shoot() {}
}


class DartMonkey extends Tower {
  DartMonkey(float x, float y) {
    super(x, y, 100, 20, dartMonkeyPic, 50);
    speed = 15;
    delay = 25;
  }

  void shoot() {
    int max = -1;  // save the pos the first balloon in shootRadius

    //Check all the balloons in balloonList and find the balloon with the highest position
    for (int i=0; i < balloonNum; i++) {
      //skip popped balloons
      if (balloonList[i].status == 1)
        continue;
      if (touch(this, balloonList[i]) && balloonList[i].position > max)
        max = balloonList[i].position;
    }

    //if that highest position is -1 ( primitive ) ===> There is no balloon
    if ( max == -1 )
      return;

    //For every 1s , 1 Weapon is created 
    if ( frameCount % delay == 1 ) {
      //distance from the tower cordinate to the track cordinate 
      float d =dist(track.x[max], track.y[max], x, y);

      //Speed in term of x,y direction 
      float xSpeed = (track.x[max] - x) * speed / d;
      float ySpeed = (track.y[max] - y) * speed / d;

      //create new weapon
      Dart wp = new Dart( x, y, xSpeed, ySpeed);
      weaponList[weaponNum] = wp;
      weaponNum++;
    }
  }
}


class IceTower extends Tower {
  int freezeTime = 10;
  
  IceTower(float x, float y) {
    super(x, y, 100, 20, iceTowerPic, 75);
    delay = 75;
  }

  void shoot() {
    for (int i=0; i < balloonNum; i++) {
      //skip popped balloons
      if (balloonList[i].status == 1)
        continue;
      if (touch(this, balloonList[i])) 
        balloonList[i].freeze = freezeTime;
    }
  }
}


class BombTower extends Tower {

  BombTower(float x, float y) {
    super(x, y, 100, 27, bombTowerPic, 150);
    speed = 20;
    delay = 13;
  }

  void shoot() {
    int max = -1;  // save the pos the first balloon in shootRadius

    //Check all the balloons in balloonList and find the balloon with the highest position
    for (int i=0; i < balloonNum; i++) {
      //skip popped balloons
      if (balloonList[i].status == 1)
        continue;
      if (touch(this, balloonList[i]) && balloonList[i].position > max)
        max = balloonList[i].position;
    }

    //if that highest position is -1 ( primitive ) ===> There is no balloon
    if ( max == -1 )
      return;

    //For every 1s , 1 Weapon is created 
    if ( frameCount % delay == 1 ) {
      //distance from the tower cordinate to the track cordinate 
      float d =dist(track.x[max], track.y[max], x, y);

      //Speed in term of x,y direction 
      float xSpeed = (track.x[max] - x) * speed / d;
      float ySpeed = (track.y[max] - y) * speed / d;

      //create new weapon
      Bomb wp = new Bomb( x, y, xSpeed, ySpeed);
      weaponList[weaponNum] = wp;
      weaponNum++;
    }
  }
}


class SuperMonkey extends Tower {
  SuperMonkey(float x, float y) {
    super(x, y, 100, 20, superMonkeyPic, 250);
    speed = 25;
    delay = 7;
  }

  void shoot() {
    int max = -1;  // save the pos the first balloon in shootRadius

    //Check all the balloons in balloonList and find the balloon with the highest position
    for (int i=0; i < balloonNum; i++) {
      //skip popped balloons
      if (balloonList[i].status == 1)
        continue;
      if (touch(this, balloonList[i]) && balloonList[i].position > max)
        max = balloonList[i].position;
    }

    //if that highest position is -1 ( primitive ) ===> There is no balloon
    if ( max == -1 )
      return;

    //For every 1s , 1 Weapon is created 
    if ( frameCount % delay == 1 ) {
      //distance from the tower cordinate to the track cordinate 
      float d =dist(track.x[max], track.y[max], x, y);

      //Speed in term of x,y direction 
      float xSpeed = (track.x[max] - x) * speed / d;
      float ySpeed = (track.y[max] - y) * speed / d;

      //create new weapon
      Laser wp = new Laser( x, y, xSpeed, ySpeed);
      weaponList[weaponNum] = wp;
      weaponNum++;
    }
  }
}