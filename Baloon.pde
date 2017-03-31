abstract class Balloon {
  int position;                    // position of balloon in track.x and track.y
  int speed;                       // number of positon balloon will skip when move
  int health;
  PImage img;
  int status = 0;                  // 0 = in game, 1 = poped
    
  Balloon(int tmp_position) {
    position = tmp_position;
  }
}


class RedBalloon extends Balloon {
  RedBalloon(int tmp_pos) {
    super(tmp_pos);
    speed = 1;
    health = 1;
    img = redBalloonPic;
  }
}

/*
class BlueBalloon extends Balloon {}
class GreenBalloon extends Balloon {}
*/