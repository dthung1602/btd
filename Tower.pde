abstract class Tower {
  float x,y;
  float shootRadius;
  float buildRadius;
  PImage img;
  int price;
  
  Tower (float tmp_x, float tmp_y, float tmp_shootRadius, float tmp_buildRadius, PImage tmp_image, int tmp_price) {
    x = tmp_x;
    y = tmp_y;
    shootRadius = tmp_shootRadius;
    buildRadius = tmp_buildRadius;
    img = tmp_image;
    price = tmp_price;
  }
  
  void shoot(int tmp) {}
}


class DartMonkey extends Tower {
  DartMonkey(float x, float y){
    super(x,y,150,30,loadImage("./Pic/monkey.png"),150);
  }
  
  void shoot(int tmp) {
    //should have delay time
    println("shoot ballon ",tmp);
  }
}

class IceTower {}
class BombTower {}
class SuperMonkey {}