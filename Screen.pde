class Screen {
  PImage bg;
  Button buttonList[];
  color cl;
  
  Screen (PImage tmp_bg, Button tmp_buttonList[], color tmp_cl) {
    bg = tmp_bg;
    buttonList = tmp_buttonList;
    cl = tmp_cl;
  }
}