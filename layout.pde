Page systemPage;
int TICK;
Cell surfaceCell;
Grid testGrid;
Page pageTest;
Page pageProfile;
Page pageNutrition;
Page pageActivity;
Page pageExplore;
Layer systemLayer;
Screen profileIcon;
void initSystem(){
  TICK = 0;
  
  surfaceCell = new Cell(0,0,1,1);
  
  pageProfile = new Page("PROFILE",1,0);
  pageNutrition = new Page("NUTRITION",0,0);
  pageActivity = new Page("ACTIVITY",0,0);
  pageExplore = new Page("EXPLORE",1.2,0);
  
  systemLayer = new Layer();
  Label header = new Label("PROFILE",30,0,0.9,1,0.05,800,80);
  systemLayer.addElement(header);
  Screen footer = new Screen(0,-0.9,1,0.05,systemPallet.panel);
  systemLayer.addElement(footer);
  Button toNutrition = new Button(-0.6,-0.9,0.1,0.05,new loadPage(pageNutrition,pageProfile));
  systemLayer.addElement(toNutrition);
  Button toActivity = new Button(0,-0.9,0.1,0.05,new loadPage(pageActivity,pageProfile));
  systemLayer.addElement(toActivity);
  Button toExplore = new Button(0.6,-0.9,0.1,0.05,new loadPage(pageExplore,pageProfile));
  systemLayer.addElement(toExplore);
  
  pageTest = new Page("TEST",1,0);
  systemPage = pageProfile;

  
  testGrid = new Grid(5,8,0,0,1,0.8,true);
  testGrid.addElement(new Spot(0,0,0.05),0,0);
  testGrid.addElement(new Spot(0,0,0.05),1,1);
  testGrid.addElement(new Spot(0,0,0.05),2,2);
  testGrid.addElement(new Button(0,0,0.8,0.8,new loadPage(pageProfile)),3,5);
  Grid subgrid = new Grid(2,2,0,0,1,1,true);
  subgrid.addElement(new Spot(0,0,0.025),0,1);
  testGrid.addElement(subgrid,1,4);
  pageTest.mainLayer.elements.add(testGrid);
  
  profileIcon=new Screen(0,0.5,0.25,0.125,200,200);
  profileIcon.pg.beginDraw();
  profileIcon.pg.stroke(systemPallet.screen);
  profileIcon.pg.strokeWeight(200);
  profileIcon.pg.point(100,100);
  profileIcon.pg.stroke(systemPallet.back);
  profileIcon.pg.strokeWeight(100);
  profileIcon.pg.point(100,100);
  profileIcon.pg.point(100,200);
  profileIcon.pg.endDraw();
  pageProfile.mainLayer.addElement(profileIcon);
  //pageProfile.mainLayer.addElement(new Spot(0,0.5,0.25));
  
  Grid profileGrid = new Grid(2,10,0,-0.75,0.75,1);
  for(int x = 0;x < 2;x ++){
    for(int y = 0;y < 10;y ++){
      profileGrid.addElement(new Label("label",20,0,0,0.45,0.4,120,64),x,y);
    }
  }
  pageProfile.mainLayer.addElement(profileGrid);
  
  
  pageNutrition.mainLayer.addElement(new FoodGraphic(0,0.2,0.4,0.2));
  pageNutrition.mainLayer.addElement(new Button(0,-0.4,0.4,0.1,null,"survey"));
  
  pageActivity.mainLayer.addElement(new StepsGraphic(0,0.2,0.4,0.2));
  pageActivity.mainLayer.addElement(new Button(0,-0.4,0.4,0.1,null,"get steps"));
  
  Grid exploreGrid = new Grid(2,10,0,-1,0.8,1);
  pageExplore.mainLayer.addElement(exploreGrid);
  exploreGrid.addElement(new Label("nutrition",20,0,0,0.45,0.4,120,64),0,9);
  exploreGrid.addElement(new Label("activity",20,0,0,0.45,0.4,120,64),1,9);
  for(int x = 0;x < 2;x ++){
    for(int y = 0;y < 9;y ++){
      exploreGrid.addElement(new Button(0,0,0.9,0.8,null,"read me"),x,y);
    }
  }
  Layer exploreOverlay = new Layer(0,0);
  Screen exploreWindow = new Screen(0,0.4,0.4,0.15);
  exploreWindow.pg.beginDraw();
  exploreWindow.pg.background(systemPallet.screen);
  exploreWindow.pg.endDraw();
  exploreOverlay.addElement(new Screen(0,0.4,0.4,0.2,1,1,color(systemPallet.back)));
  exploreOverlay.addElement(exploreWindow);
  pageExplore.layers.add(exploreOverlay);
  
}
void runSystem(){
  TICK++;
  Label header = (Label)systemLayer.elements.get(0);
  header.text=systemPage.name;
  systemLayer.run(surfaceCell);
  systemPage.run(surfaceCell);
}


class Page{
  ArrayList<Layer> layers;
  Layer mainLayer;
  String name;
  Page(float c,float f){
    layers = new ArrayList<Layer>();
    mainLayer = new Layer(c,f);
    layers.add(mainLayer);
  }
  Page(String name,float c,float f){
    layers = new ArrayList<Layer>();
    mainLayer = new Layer(c,f);
    layers.add(mainLayer);
    this.name=name;
  }
  void addLayer(Layer layer){
    layers.add(layer);
  }
  void run(Cell cell){
    for(int i = 0;i < layers.size();i ++){
      layers.get(i).run(cell);
    }
  }
}

class Layer{
  ArrayList<Element> elements;
  Float scrollY = 0f;
  boolean scroll;
  float ceiling;
  float floor;
  Layer(){
    elements = new ArrayList<Element>();
    scroll=false;
  }
  Layer(float ceiling,float floor){
    elements = new ArrayList<Element>();
    scroll=(ceiling>0||floor<0);
    this.ceiling=ceiling;
    this.floor=floor;
  }
  void addElement(Element element){
    elements.add(element);
  }
  void run(Cell cell){
    if(scroll){
      scrollY+=mouseScroll/25;
    }
    if(scrollY>ceiling){
      scrollY=ceiling;
    }
    if(scrollY<floor){
      scrollY=floor;
    }
    for(int i = 0;i < elements.size();i ++){
      elements.get(i).run(new Cell(cell.x,cell.y+scrollY,cell.w,cell.h));
      if(elements.get(i) instanceof Label){
        //println("label");
      }
    }
  }
}

class Element{
  void run(Cell cell){};
}

class Cell{
  float x;
  float y;
  float w;
  float h;
  Cell(float x,float y,float w,float h){
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
}


class Spot extends Element{
  float x,y,r;
  Spot(float x,float y,float r){
    this.x=x;
    this.y=y;
    this.r=r;
  }
  void run(Cell cell){
    //r=abs(r+sin(TICK*50)*2);
  }
}

class Screen extends Element{
  PGraphics pg;
  float x;
  float y;
  float w;
  float h;
  Screen(float x,float y,float w,float h){
    pg = createGraphics(round(w*width),round(h*height));
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.endDraw();
  }
  Screen(float x,float y,float w,float h,int rw,int rh){
    pg = createGraphics(rw,rh);
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.endDraw();
  }
  Screen(float x,float y,float w,float h,color c){
    pg = createGraphics(round(w*width),round(h*height));
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(c);
    pg.endDraw();
  }
  Screen(float x,float y,float w,float h,int rw,int rh,color c){
    pg = createGraphics(rw,rh);
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(c);
    pg.endDraw();
  }
  void run(Cell cell){};
}

class Label extends Screen{
  String text;
  int size;
  Label(String text,int size,float x,float y,float w,float h){
    super(x,y,w,h);
    this.text=text;
    this.size=size;
    refresh();
  }
  Label(String text,int size,float x,float y,float w,float h,int rw,int rh){
    super(x,y,w,h,rw,rh);
    this.text=text;
    this.size=size;
    refresh();
  }
  void refresh(){
    pg.beginDraw();
    pg.background(systemPallet.panel);
    pg.fill(systemPallet.text);
    pg.textAlign(CENTER);
    pg.textSize(size);
    pg.text(text,pg.width/2,pg.height/2);
    pg.endDraw();
  }
  void run(Cell cell){
    refresh();
  }
  String getText(){return text;}
}

class Grid extends Element{
  int rows;
  int columns;
  Element[][] cells;
  boolean visible;
  float x = -1;
  float y = -1;
  float w = 2;
  float h = 2;
  Grid(int c,int r){
    rows=r;
    columns=c;
    cells = new Element[c][r];
  }
  Grid(int c,int r,boolean v){
    rows=r;
    columns=c;
    visible = v;
    cells = new Element[c][r];
  }
  Grid(int c,int r,float x,float y,float w,float h){
    rows=r;
    columns=c;
    cells = new Element[c][r];
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  Grid(int c,int r,float x,float y,float w,float h,boolean v){
    rows=r;
    columns=c;
    visible = v;
    cells = new Element[c][r];
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  void addElement(Element element,int c,int r){
    cells[c][r]=element;
  }
  float[] cellPos(int cx,int cy){
    return new float[] {x+(cx*w),y+(cy*h),w/columns,h/rows};
  }
  Cell getCell(int cx,int cy){
    return new Cell(x+(((2.0*(cx+0.5))/columns-1)*w),y+(((2.0*(cy+0.5))/rows-1)*h),(float)w/columns,(float)h/rows);
  }
  void run(Cell cell){
    for(int x = 0;x < columns;x ++){
      for(int y = 0;y < rows;y ++){
        if(cells[x][y]!=null){
          cells[x][y].run(wrapCell(getCell(x,y),cell));
        }
      }
    }
  }
}

class Button extends Element{
  float x;
  float y;
  float w;
  float h;
  Function function;
  String name;
  PGraphics basePG;
  PGraphics highPG;
  PGraphics clickPG;
  boolean highlight = false;
  Button(float x,float y,float w,float h,Function f){
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.function=f;
  }
  Button(float x,float y,float w,float h,Function f,String name){
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.function=f;
    this.name=name;
  }
  void addGraphics(PGraphics basePG,PGraphics highPG,PGraphics clickPG){
    this.basePG=basePG;
    this.highPG=highPG;
    this.clickPG=clickPG;
  }
  void run(Cell cell){
    float[] ba = {x-w,y-h};
    float[] bb = {x+w,y+h};
    
    float[] ca = cellTrans(ba[0],ba[1],cell);
    float[] cb = cellTrans(bb[0],bb[1],cell);
    
    float[] a = surfaceTrans(ca[0],ca[1]);
    float[] b = surfaceTrans(cb[0],cb[1]);
    
    //println(a[0]+" , "+a[1]+" ' "+b[0]+" , "+b[1]);
    highlight=false;
    if(mouseX>a[0]&&mouseX<b[0]&&mouseY<a[1]&&mouseY>b[1]){
      //println("mouseover");
      highlight=true;
      if(iMOUSE==1){
        if(function!=null){
          function.execute();
        }
        //println("click");
      }
    }
  }
}
class Function{
  void execute(){}
}
class loadPage extends Function{
  Page page;
  Page back;
  loadPage(Page page){
    this.page=page;
  }
  loadPage(Page page,Page back){
    this.page=page;
    this.back=back;
  }
  void execute(){
    if(systemPage!=page){
      systemPage=page;
    } else {
      if(back!=null){
        systemPage=back;
      }
    }
  }
}

class FoodGraphic extends Screen{
  FoodGraphic(float x,float y,float w,float h){
    super(x,y,w,h);
    pg.beginDraw();
    pg.background(systemPallet.screen);
    pg.endDraw();
  }
}
class StepsGraphic extends Screen{
  StepsGraphic(float x,float y,float w,float h){
    super(x,y,w,h);
    pg.beginDraw();
    pg.background(systemPallet.screen);
    pg.endDraw();
  }
}
