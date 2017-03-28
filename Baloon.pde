abstract class Balloon {
  int position;
  float speed; 
  int health;
  PImage img;
  int status = 0; // 0 = not yet in game, 1 = in game, 2 = poped
    
  Balloon(int pos) {
    position = pos;
  }
}


class RedBalloon extends Balloon {
  RedBalloon(int tmp_pos) {
    super(tmp_pos);
    speed = 1;
    health = 1;
    img = loadImage("./Pic/redballoon.png");
  }
}

/*
class BlueBalloon extends Balloon {}
class GreenBalloon extends Balloon {}*/