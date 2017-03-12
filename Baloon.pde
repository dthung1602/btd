abstract class Baloon {
  float x,y;
  float speed;
  int health;
  PImage img;
  int status = 0;
  int line = 0;
  int stepInLine;
  
  Baloon(float tmp_x, float tmp_y) {
    x = tmp_x;
    y = tmp_y;
  }
}

class RedBaloon extends Baloon {
  RedBaloon(float tmp_x, float tmp_y) {
    super(tmp_x, tmp_y);
    speed = 1;
    health = 1;
    img = loadImage("./Pic/background.jpg");
  }
}