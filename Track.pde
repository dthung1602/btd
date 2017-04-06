class Track {
  int trackNum;  
  int trackWidth;
  int defaultHealth;
  int defaultMoney;
  
  //x,y hold posible balloon positions on the screen
  float x[];
  float y[];
    
  Track(String fileName) {
    // read file to initialize object
    trackWidth = 10;
    x = new float [0];
    y = new float [0];
  }
}