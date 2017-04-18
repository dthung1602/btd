class Track {
  int trackNum;                 // tells if track is track0 or track1, ...
  int trackWidth = 12;          // towers must not be placed closer to balloon path than 12px 
  int defaultHealth = 50;
  int defaultMoney = 75000;

  //x,y hold posible balloon positions on the screen
  float x[];
  float y[];

  Track(int num) {
    trackNum = num;
    
    //load data from file
    String[] data = loadStrings("./Data/track" + str(num) + ".txt");
    String tmp [];
    x = new float [data.length];
    y = new float [data.length];
    
    //put data to x[], y[]
    for (int i=0; i<data.length; i++) {
      tmp = split(data[i], " ");
      x[i] = (float) int(tmp[0]);
      y[i] = (float) int(tmp[1]);
    }
  }
}