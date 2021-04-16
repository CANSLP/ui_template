class Pallet{
  color back;
  color panel;
  color text;
  color screen;
  color button;
  color buttonH;
  color buttonC;
  Pallet(color back,color panel,color text,color screen,color button,color buttonH,color buttonC){
    this.back=back;
    this.panel=panel;
    this.text=text;
    this.screen=screen;
    this.button=button;
    this.buttonH=buttonH;
    this.buttonC=buttonC;
  }
}

Pallet systemPallet;
Pallet palDefault;
Pallet palTest;
Pallet palModern;

void initGraphics(){
  colorMode(HSB);
  palDefault=new Pallet(color(0),color(255),color(0),color(150),color(225),color(235),color(200));
  palTest=new Pallet(color(200,255,50),color(200,100,200),color(200,255,50),color(125,85,150),color(125,150,250),color(125,100,255),color(125,255,100));
  palModern=new Pallet(color(150,10,255),color(150,50,255),color(150,200,50),color(0,100,100),color(0,50,200),color(0,50,255),color(0,100,100));
  systemPallet=palModern;
}
void drawPage(Page page){
  background(systemPallet.back);
  for(int l = 0;l < page.layers.size();l ++){
    drawLayer(page.layers.get(l));

  }
  drawLayer(systemLayer);
}

void drawLayer(Layer layer){
  for(int e = 0;e < layer.elements.size();e ++){
      Element element = layer.elements.get(e);
      drawElement(element,new Cell(surfaceCell.x,surfaceCell.y+layer.scrollY,surfaceCell.w,surfaceCell.w));
    }
}

void drawElement(Element element,Cell cell){
  if(element instanceof Spot){
    drawSpot((Spot) element,cell);
  }
  if(element instanceof Screen){
    drawScreen((Screen) element,cell);
  }
  if(element instanceof Grid){
    drawGrid((Grid) element,cell);
  }
  if(element instanceof Button){
    drawButton((Button) element,cell);
  }
}

void drawSpot(Spot spot,Cell cell){
  float[] cpos = cellTrans(spot.x,spot.y,cell);
  float[] pos = surfaceTrans(cpos[0],cpos[1]);
  stroke(systemPallet.panel);
  strokeWeight(spot.r*pos[2]);
  point(pos[0],pos[1]);
}
void drawScreen(Screen screen,Cell cell){
  float[] cpos = cellTrans(screen.x,screen.y,cell);
  float[] pos = surfaceTrans(cpos[0],cpos[1]);
  image(screen.pg,pos[0]-screen.w*cell.w*width,pos[1]-screen.h*cell.h*height,screen.w*cell.w*width*2,screen.h*cell.h*height*2);
}
void drawButton(Button button,Cell cell){
  noStroke();
  
  float[] cpos = cellTrans(button.x,button.y,cell);
  float[] pos = surfaceTrans(cpos[0],cpos[1]);
  fill(systemPallet.button);
  if(button.highlight){
    if(iMOUSE==1){
      fill(systemPallet.buttonC);
    } else {
      fill(systemPallet.buttonH);
    }
  }
  rect(pos[0]-button.w*cell.w*width*0.5,pos[1]-button.h*cell.h*height*0.5,button.w*cell.w*width*1,button.h*cell.h*height*1);
  if(button.name!=null){
    fill(systemPallet.text);
    textAlign(CENTER);
    text(button.name,pos[0],pos[1]);
  }
}
void drawGrid(Grid grid,Cell cell){
  strokeWeight(3);
  stroke(systemPallet.panel);
  if(grid.visible){
    for(int x = 0;x < grid.columns+1;x ++){
      float[] ca = cellTrans((grid.w*x*2)/grid.columns+grid.x-grid.w,grid.y-grid.h,cell);
      float[] cb = cellTrans((grid.w*x*2)/grid.columns+grid.x-grid.w,grid.y+grid.h,cell);
      float[] a = surfaceTrans(ca[0],ca[1]);
      float[] b = surfaceTrans(cb[0],cb[1]);
      line(a[0],a[1],b[0],b[1]);
    }
    for(int y = 0;y < grid.rows+1;y ++){
      float[] ca = cellTrans(grid.x-grid.w,(grid.h*y*2)/grid.rows+grid.y-grid.h,cell);
      float[] cb = cellTrans(grid.x+grid.w,(grid.h*y*2)/grid.rows+grid.y-grid.h,cell);
      float[] a = surfaceTrans(ca[0],ca[1]);
      float[] b = surfaceTrans(cb[0],cb[1]);
      line(a[0],a[1],b[0],b[1]);
    }
  }
  for(int x = 0;x < grid.columns;x ++){
    for(int y = 0;y < grid.rows;y ++){
      drawElement(grid.cells[x][y],wrapCell(grid.getCell(x,y),cell));
    }
  }
}

float[] surfaceTrans(float x,float y){
  return new float[] {(width/2)*(x+1),(height/2)*(1-y),(width+height)/2};
}
float[] cellTrans(float x,float y,Cell cell){
  return new float[] {cell.x+(x*cell.w),cell.y+(y*cell.h)};
}
float[] cellTrans(float x,float y,float px,float py,float pw,float ph){
  return new float[] {px+(x*pw),py+(y*ph)};
}
float screenScale(){
  return (width+height)/2;
}
Cell wrapCell(Cell subcell,Cell base){
  return new Cell(base.x+(subcell.x*base.w),base.y+(subcell.y*base.h),subcell.w*base.w,subcell.h*base.h);
}
float[] invSurfaceTrans(float x,float y){
  return new float[]{x/(width/2)-1,1-(y/(height/2))};
}
float[] invCellTrans(float x,float y,Cell cell){
    return new float[] {(x-cell.x)/cell.w,(y-cell.y)/cell.h};

}
