void setup(){
  size(400,800);
  surface.setResizable(true);
  colorMode(HSB);
  //noSmooth();
  initGraphics();
  initSystem();
  
}

void draw(){
  /*background(0);
  fill(255);
  noStroke();
  rect(0,0,width,height/8);
  rect(0,height*(7/8.0),width,height/8);*/
  uiUpdate();
  runSystem();
  drawPage(systemPage);
  if(false){
    saveFrame("recording/frame-"+TICK+".jpg");
  }
}
