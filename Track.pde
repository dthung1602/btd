class Track {
  int level;
  PImage bg;
  int trackWidth = 10;
  
  int defaultHealth;
  int defaultMoney;
    
  //x,y holds posible balloon positions on the screen
  float x[];
  float y[];
  int posInGame;
  Balloon balloonList [];
    
  Track(String fileName) {
    x = new float [0];
    y = new float [0];
  }
}