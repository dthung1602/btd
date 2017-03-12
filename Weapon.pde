static abstract class Weapon {
  float x,y;
  float speedX, speedY;
  
  Weapon (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    x = tmp_x;
    y = tmp_y;
    speedX = tmp_speedX;
    speedY = tmp_speedY;
  }
  
  /**/
  void pop() {
    for (int i=0; i<3; i++)
      println("pop baloon ",i);
  }
}


static class Dart extends Weapon{  
  static float speed;/**/
  static int damage;
  static PImage img;
  static int count;
  
  Dart (float tmp_x, float tmp_y, float tmp_speedX, float tmp_speedY) {
    super(tmp_x, tmp_y, tmp_speedX, tmp_speedY);
  }
}