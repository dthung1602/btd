void mousePressed() {
  for (int i=0; i<screen.buttonList.length; i++)
    if (screen.buttonList[i].containPoint(mouseX,mouseY))     
      screen.buttonList[i].action();
}