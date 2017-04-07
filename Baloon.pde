abstract class Balloon {
  int position = 0;                // position of balloon in track.x and track.y
  int speed;                       // number of positon balloon will skip when move
  int health;                      
  PImage img;
  int status = 0;                  // 0 = in game, 1 = poped
  int freeze = 0;                  // freezing time
  int moneyBonus;                  // how much money player get when balloon is popped
}


class RedBalloon extends Balloon {
  RedBalloon() {
    speed = 1;
    health = 1;
    img = redBalloonPic;
    moneyBonus = 5;
  }
}


class BlueBalloon extends Balloon {
  BlueBalloon() {
    speed = 2;
    health = 2;
    img = blueBalloonPic; 
    moneyBonus = 10;
  }
}


class GreenBalloon extends Balloon {
  GreenBalloon() {
    speed = 3;
    health = 3;
    img = greenBalloonPic;
    moneyBonus = 17;
  }
}


class YellowBalloon extends Balloon {
  YellowBalloon() {
    speed = 4;
    health = 4;
    img = yellowBalloonPic;
    moneyBonus = 23;
  }
}


class PinkBalloon extends Balloon {
  PinkBalloon() {
    speed = 5;
    health = 5;
    img = pinkBalloonPic;
    moneyBonus = 35;
  }
}


class RainbowBalloon extends Balloon {
  RainbowBalloon() {
    speed = 5;
    health = 15;
    img = rainbowBalloonPic;
    moneyBonus = 125;
  }
}