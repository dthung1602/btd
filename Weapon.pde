abstract class Weapon {
  float x, y;
  float speedX, speedY;
  float popRadius;
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
  
  void pop() {}
}


class Dart extends Weapon{    
  Dart (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    super(tmp_x, tmp_y, tmp_speedX, tmp_speedY);
  }
}

/*
class Ice extends Weapon{  }
class Bomb extends Weapon{  }
class Laser extends Weapon{  }
*/