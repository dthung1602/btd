abstract class Button {
  float x1,y1;
  float x2,y2;
  
  Button(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    x1 = tmp_x1;
    y1 = tmp_y1;
    x2 = tmp_x2;
    y2 = tmp_y2;
  }
  
  boolean containPoint(float X, float Y) {
    if (x1<=X && X<x2 && y1<Y && Y<y2)
      return true;
    return false;
  }
  
  void action() {}
}


class GoButton extends Button {
  PImage img;/**/
  
  GoButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    println("Go Go Go");
    pausing = true;
    menu();
  }
}


class NewGameButton extends Button {
  PImage img;/**/
  
  NewGameButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    println("NEW game!");
    screen = playScreen;
    fill(255,255,0,100);
    pausing = false;
  }
}


class StartButton extends Button {
  PImage img;/**/
  
  StartButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    println("Play button");
    frameRate(40);
    starting = true;
  } 
}


class FastForwardButton extends Button {
  PImage img;/**/
  
  FastForwardButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    frameRate(60);
  } 
}

class SlowDownButton extends Button {
  PImage img;/**/
  
  SlowDownButton(float tmp_x1, float tmp_y1, float tmp_x2, float tmp_y2) {
    super(tmp_x1,tmp_y1,tmp_x2,tmp_y2);
  }
  
  void action() {
    frameRate(40);
  } 
}