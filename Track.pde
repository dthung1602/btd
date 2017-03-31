class Track {
  PImage bg;
  int trackWidth;
  int round;  
  int defaultHealth;
  int defaultMoney;
    
  //x,y holds posible balloon positions on the screen
  float x[];
  float y[];
    
  Track(String fileName) {
    // read file to initialize object
    trackWidth = 5;
    x = new float [0];
    y = new float [0];
  }
}