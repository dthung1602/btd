abstract class Balloon {
  float x,y;
  float speed; // how fast the balloon move
  float xSpeed, ySpeed; // real speed of balloon in Oxy plane, = speed * direction of line of track that balloon is currrently on
  int line = 0; // line of track that balloon is currently on
  int stepInLine; // number of steps balloon needs to go the end of current line
  int health;
  PImage img;
  int status = 0; // 0 = not yet in game, 1 = in game, 2 = poped
  
  
  Balloon(float tmp_x, float tmp_y) {
    x = tmp_x;
    y = tmp_y;
  }
}

class RedBalloon extends Balloon {
  RedBalloon(float tmp_x, float tmp_y) {
    super(tmp_x, tmp_y);
    speed = 1;
    health = 1;
    img = loadImage("./Pic/redballoon.png");
    xSpeed = speed * track.xSpeed[0];
    ySpeed = speed * track.ySpeed[0];
    stepInLine = (int) abs( (track.x[0]-x) / xSpeed ); // step = distance / length of each step; length of step is speed
    println(stepInLine);
  }
}