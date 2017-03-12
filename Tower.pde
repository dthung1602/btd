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
  
  void shoot() {}
}

class DartMonkey extends Tower {
  DartMonkey(float x, float y){
    super(x,y,15,15,screen.bg,150);
  }
  
  
  void shoot() {
    println("pang pang pang");
  }
}

class IceTower {}
class BombTower {}
class SuperMonkey {}