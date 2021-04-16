
boolean hUP;
int iUP;
boolean hDOWN;
int iDOWN;
boolean hRIGHT;
int iRIGHT;
boolean hLEFT;
int iLEFT;
boolean hR;
int iR;
boolean hE;
int iE;
boolean hSPACE;
int iMOUSE;
int iRMOUSE;
int iMMOUSE;
boolean hENTER;
int iENTER;
boolean hSHIFT;
int iSHIFT;
boolean hTAB;
int iTAB;
float mouseScroll;
float mouseSV = 0;
float msLAST = 0;
void uiUpdate(){
  if(mousePressed&&mouseButton==LEFT){
    if(iMOUSE == 0){
      iMOUSE = 1;
    } else {
      iMOUSE = 2;
    }
  } else {
    iMOUSE = 0;
  }
  if(mousePressed&&mouseButton==RIGHT){
    if(iRMOUSE == 0){
      iRMOUSE = 1;
    } else {
      iRMOUSE = 2;
    }
  } else {
    iRMOUSE = 0;
  }
  if(mousePressed&&mouseButton==CENTER){
    if(iMMOUSE == 0){
      iMMOUSE = 1;
    } else {
      iMMOUSE = 2;
    }
  } else {
    iMMOUSE = 0;
  }
  if(hENTER){
    if(iENTER == 0){
      iENTER = 1;
    } else {
      iENTER = 2;
    }
  } else {
    iENTER = 0;
  }
  if(hSHIFT){
    if(iSHIFT == 0){
      iSHIFT = 1;
    } else {
      iSHIFT = 2;
    }
  } else {
    iSHIFT = 0;
  }
  if(hTAB){
    if(iTAB == 0){
      iTAB = 1;
    } else {
      iTAB = 2;
    }
  } else {
    iTAB = 0;
  }
  if(hR){
    if(iR == 0){
      iR = 1;
    } else {
      iR = 2;
    }
  } else {
    iR = 0;
  }
  if(hE){
    if(iE == 0){
      iE = 1;
    } else {
      iE = 2;
    }
  } else {
    iE = 0;
  }
  
  if(hUP){
    if(iUP == 0){
      iUP = 1;
    } else {
      iUP = 2;
    }
  } else {
    iUP = 0;
  }
  if(hDOWN){
    if(iDOWN == 0){
      iDOWN = 1;
    } else {
      iDOWN = 2;
    }
  } else {
    iDOWN = 0;
  }
  if(hRIGHT){
    if(iRIGHT == 0){
      iRIGHT = 1;
    } else {
      iRIGHT = 2;
    }
  } else {
    iRIGHT = 0;
  }
  if(hLEFT){
    if(iLEFT == 0){
      iLEFT = 1;
    } else {
      iLEFT = 2;
    }
  } else {
    iLEFT = 0;
  }

  mouseScroll=mouseScroll*0.5;
  if(abs(mouseScroll)<0.01){
    mouseScroll=0;
  }
}

void keyPressed(){
  if(keyCode == 38 || keyCode == 87){
      hUP = true;
  }
  if(keyCode == 39 || keyCode == 68){
      hRIGHT = true;
  }
  if(keyCode == 37 || keyCode == 65){
      hLEFT = true;
  }
  if(keyCode == 40 || keyCode == 83){
      hDOWN = true;
  }
  if(keyCode == 82){
    hR = true;
  }
  if(keyCode == 69){
    hE = true;
  }
  if(keyCode == 32){
    hSPACE = true;
  }
  if(keyCode == 10){
    hENTER = true;
  }
  if(keyCode == 16){
    hSHIFT = true;
  }
  if(keyCode == 9){
    hTAB = true;
  }
  //println(keyCode);
}
void keyReleased(){
  if(keyCode == 38 || keyCode == 87){
      hUP = false;
  }
  if(keyCode == 39 || keyCode == 68){
      hRIGHT = false;
  }
  if(keyCode == 37 || keyCode == 65){
      hLEFT = false;
  }
  if(keyCode == 40 || keyCode == 83){
    hDOWN = false;
  }
  if(keyCode == 82){
    hR = false;
  }
  if(keyCode == 69){
    hE = false;
  }
  if(keyCode == 32){
    hSPACE = false;
  }
  if(keyCode == 10){
    hENTER = false;
  }
  if(keyCode == 16){
    hSHIFT = false;
  }
  if(keyCode == 9){
    hTAB = false;
  }
}

void mouseWheel(MouseEvent event) {
  mouseScroll = event.getCount();
}
