abstract class Balloon {
  int position = 0;                // position of balloon in track.x and track.y
  int speed;                       // number of positon balloon will skip when move
  int health;
  PImage img;
  int status = 0;                  // 0 = in game, 1 = poped
  int freeze = 0;                  // freezing time
    
  Balloon() {}
}


class RedBalloon extends Balloon {
  RedBalloon() {
    super();
    speed = 1;
    health = 1;
    img = redBalloonPic;
  }
}


class BlueBalloon extends Balloon {
  BlueBalloon() {
    super();
    speed = 2;
    health = 2;
    img = blueBalloonPic; // add blueBalloonPic + another bloons' pics
  }
}


class GreenBalloon extends Balloon {
  GreenBalloon() {
    super();
    speed = 3;
    health = 3;
    img = greenBalloonPic;
  }
}


class YellowBalloon extends Balloon {
  YellowBalloon() {
    super();
    speed = 4;
    health = 4;
    img = yellowBalloonPic;
  }
}


class PinkBalloon extends Balloon {
  PinkBalloon() {
    super();
    speed = 5;
    health = 5;
    img = pinkBalloonPic;
  }
}


class RainbowBalloon extends Balloon {
  RainbowBalloon() {
    super();
    speed = 4;
    health = 20;
    img = rainbowBalloonPic;
  }
}