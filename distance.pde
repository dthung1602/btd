float sqr(float x) {
  return x*x;
}

float distance(float x1, float y1, float x2, float y2) {
  return sqrt(sqr(x1-x2) + sqr(y1-y2));
}

float distance(Weapon wp, Balloon bl) {
  return sqrt(sqr(wp.x-track.x[bl.position]) + sqr(wp.y-track.y[bl.position]));
}

float distance(Tower tw1, Tower tw2) {
  return sqrt(sqr(tw1.x-tw2.x) + sqr(tw1.y-tw2.y)); 
} 

float distance(Tower tw , Balloon bl ){
    return sqrt(sqr(tw.x-track.x[bl.position]) + sqr(tw.y-track.y[bl.position]));
}

boolean touch(Tower tw1, Tower tw2) {
  if (distance(tw1,tw2) > tw1.buildRadius + tw2.buildRadius)
    return false;
  return true;
}

boolean touch(Weapon wp, Balloon bl) {
  if (distance(wp,bl) > wp.popRadius) 
    return false;
  return true;
}

boolean touchEx(Weapon wp, Balloon bl) {
  if (distance(wp,bl) > wp.explodeRadius) 
    return false;
  return true;
}

boolean touch(Tower tw, float x, float y) {
  if (distance(tw.x,tw.y,x,y) < tw.buildRadius + track.trackWidth) 
    return true;
  return false;
}

boolean touch(Tower tw, Balloon bl ){
  if (distance(tw,bl) <= tw.shootRadius)
    return true;
  return false; 
}