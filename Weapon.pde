abstract class Weapon {
  float x,y;
  float speedX, speedY;
  float speed;
  float popRadius;
  int popCount;
  int damage;
  PImage img;
  
  Weapon (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    x = tmp_x;
    y = tmp_y;
    speedX = tmp_speedX;
    speedY = tmp_speedY;
  }
  
  void pop() {
      println("pop balloon");
  }
}


class Dart extends Weapon{    
  Dart (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    super(tmp_x, tmp_y, tmp_speedX, tmp_speedY);
  }
}