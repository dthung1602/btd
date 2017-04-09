abstract class Effect {
  float x, y;          // position of effect
  int time;            // how long effect last 
  int status;          // 0 = still happen; 1 = done
  
  Effect(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show() {}
}


class FreezeEffect extends Effect {
  int radius = 0;                              // current radius, will increase
  int maxRadius = 100;                         // max radius, equals to shooting radius of ice tower
  int inc;                                     // how much radius will increase in show()
  
  FreezeEffect(float x, float y) {
    super(x, y);
    time = 5;
    inc = (int) map(1,0,time,0,maxRadius);
  }
  
  void show() {
    time -= 1;             // reduce time of effect
    if (time == 0) {       // effect has finished
      status = 1;
      return;
    } 
    radius += inc;         // incease radius
    
    //draw circle
    stroke(0,100,255);
    fill(CLEAR_BLUE);
    ellipse(x, y, radius*2, radius*2);
    noStroke();
  }
}