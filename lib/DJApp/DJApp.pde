

//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies
Vis1 vis = new Vis1();

int tvx, tvy;
int animx, animy;
int deck1x, deck1y;

int sliderx, slidery;
int volx, voly;
int colorSliderx, colorSlidery;

int playx,playy;
int vis1x, vis1y;
int vis2x, vis2y;
int vis3x, vis3y;
int rgbx, rgby;
int resetx, resety;

int vinylAx, vinylAy;
int vinylBx, vinylBy;
int vinylCx, vinylCy;

boolean reset=false;
boolean vis1=true;
boolean vis2=false;
boolean vis3=false;
boolean rgb=false;

boolean track1Playing=true;
boolean track2Playing=false;
boolean track3Playing=false;
boolean deck1Playing = false;
float rotateDeck1 = 0;
float currentFrame = 0;
int margin = width/40;

//Pimages
PImage [] images;
PImage [] recordPlayer;
PImage TV;
PImage playButton;
PImage vinyl;
PImage vidButton;
PImage resetButton;

Maxim maxim;
float speedAdjust=1.0;
float volAdjust=1.0;
int colAdjust=1;

String track="/DJApp/cb2.mp3";


void setup()
{
  size(1300,900);
  frameRate=100;
  
  //load images
  playButton=loadImage("/DJApp/play.png");
  vinyl=loadImage("/DJApp/vinyl.png");
  vidButton=loadImage("/DJApp/Rectangle.png");
  resetButton=loadImage("/DJApp/reset.png");
  
  imageMode(CENTER);
  images = loadImages("/DJApp/Animation_data/movie", ".jpg", 134);
  recordPlayer = loadImages("/DJApp/black-record_", ".png", 36);
  TV = loadImage("/DJApp/TV.png");
  maxim = new Maxim(this);
  background(10);
  
  //Text
  font=loadFont("Courier10PitchBT-Bold-14.vlw");
  textFont(font);
  textSize(14);
  

  //set up visualizers  
  vis.visSetup2(track);
  vis.visSetup(track);
  
 
 //speed slider position
 sliderx=width/2+107;
 slidery=597.5;
 
 //volume slider position
 volx=width/2+38;
 voly=597.5;
 
 //color slider position
 colorSliderx= volx+30-70;
 colorSlidery=voly+82;
 
  
 //power button position 
 playx=width/2-280;
 playy=580;
 
 
 //vinyl select positions
 vinylAx=width/2+220;
 vinylAy=597.5;
 
 vinylBx=vinylAx-14;
 vinylBy=vinylAy+75;
 
 vinylCx=vinylBx-14;
 vinylCy=vinylBy+75;
 
 //visualizer button positions
 vis1x=playx;
 vis1y=playy+70;
 
 vis2x=playx;
 vis2y=vis1y+50;
 
 vis3x=playx;
 vis3y=vis2y+50;

 rgbx=playx+300;
 rgby=vis3y;
 
 resetx=width/2-15;
 resety=580;
 
}

void draw()
{
  background(10); 

  if (deck1Playing) {
    
    //determine which visualizer to show based on bool
     if(vis3){
    vis.visDraw3();
    }
    
       //if (reset==true){
  //       slidery=597.5;
      //  voly=597.5;
        //colorSliderx= volx+30-70;
        //volAdjust=map(voly,545,650,0,2);
        //speedAdjust=map(slidery,545,650,0,2);


       //}
   
   
    if(vis1){
    vis.visDraw();
    }
     if(vis2)
    {
    vis.visDraw2();
    }
   
   
    
    
    vis.col(colAdjust);
    vis.speed(speedAdjust);
    vis.vol(volAdjust);
  
    //set visualizer speed
    vis.setRotationSpeed(speedAdjust);
    vis.setPow(volAdjust);
    
    currentFrame= currentFrame+1*speedAdjust;
  }

  if (currentFrame >= images.length) {

    currentFrame = 0;
  }

  if (deck1Playing) {

    rotateDeck1 += 1*speedAdjust;

    if (rotateDeck1 >= recordPlayer.length) {

      rotateDeck1 = 0;
    }
  }

  
  /**table**/
  colorMode(RGB);
  stroke(0);
  fill(255,255,255, 50);//add gradient to silver
  rect(width/4,height-370,width/1.8,280);
  /*******/
  
  /***slider-bar**/
  stroke(0);
    fill(140,207,240);
    rect(width/2+120, height-350, 10, 100);
   /**slider-button**/
    fill(0);
    rect(sliderx, slidery, 35, 10);
   //label
        fill(230,230,230)
    text("SPEED", width/2+104, height-235);
    text("_", width/2+106, height-345);
     text("+", width/2+106, height-255);


   /**vol-slider**/
    fill(140,207,240);
    rect(width/2+50, height-350, 10, 100);
   /**vol-slider-button**/
    fill(0);
    rect(volx, voly, 35, 10);
    //label
     fill(230,230,230)
    text("VOL", width/2+44, height-235);
    text("_", width/2+35, height-345);
     text("+", width/2+35, height-255);
     
     /**horizontal colour slider**/
      fill(120);
    rect(width/2, height-210, 140, 10);
   /**colour-slider-button**/
    fill(0);
    rect(colorSliderx, colorSlidery, 10, 30);
    //label
     fill(230,230,230)
    text("COL", 718-5, 679.5+50);
    text("_", 718-60, 679.5+28);
        text("+", 718+58, 679.5+35);

    // text("+", width/2+30, height-255);
     
     



    
    /**play btn**/
    image(playButton,playx, playy, playButton.width/6, playButton.height/6);
     fill(230,230,230)
        text("POWER", playx-28, playy-34);
        
    /**reset btn**/
    fill(195);
     ellipse(resetx, resety, 35, 35);
     fill(0);
     image(resetButton,resetx, resety, resetButton.width, resetButton.height);
     fill(230,230,230)
     text("RESET", resetx-23, resety-25);
    

    /**visual select btn**/
     fill(230,230,230)
    rect(vis2x-28, vis2y-8, 54,19 );
    fill(0)
    text("VIZ 2", vis2x-18, vis2y+7);
   
     fill(230,230,230)
    rect(vis1x-28, vis1y-8, 54,19 );
    fill(0)
    text("VIZ 1", vis1x-18, vis1y+7);
    
     fill(230,230,230)
    rect(vis3x-28, vis3y-8, 54,19 );
    fill(0)
    text("VIZ 3", vis3x-18, vis3y+7);
    
    /**rgb/hsb btn**/
    rect(rgbx-28, rgby-8, 54,19);
     fill(230,230,230)
    text("RGB", rgbx-16, rgby+6.5);
    

    /**vinyl select btn/disc**/
    image(vinyl,vinylAx, vinylAy, vinyl.width/1.5, vinyl.height/1.5);
        text("TRACK A", vinylAx+40, vinylAy+10);

    image(vinyl,vinylBx, vinylBy, vinyl.width/1.5, vinyl.height/1.5);
            text("TRACK B", vinylBx+40, vinylBy+10);

    image(vinyl,vinylCx, vinylCy, vinyl.width/1.5, vinyl.height/1.5);
               text("TRACK C", vinylCx+40, vinylCy+10);

       
     fill(255, 20, 0, 100);
     ellipse(vinylAx, vinylAy, 65, 65);
      
     fill(236, 237, 7, 80);
     ellipse(vinylBx, vinylBy, 65, 65);
     
     fill(50, 0, 250, 100);
     ellipse(vinylCx, vinylCy, 65, 65);

    noFill();
  /*******/
  
    
  /**decks**/
  deck1x = (width/2)-recordPlayer[0].width/2-(margin*10);
  deck1y = TV.height+recordPlayer[0].height/2+margin+240;
  image(recordPlayer[(int) rotateDeck1], deck1x, deck1y, recordPlayer[0].width/1.2, recordPlayer[0].height/1.2);
 
 
 /***light/power signals***/
   if(track1Playing){
  
     fill(255, 20, 0, 150);
     ellipse(deck1x, deck1y, 80, 80);
     
     fill(0, 200, 220, 150);
     ellipse(vinylAx, vinylAy, 20, 20);
     noFill();
  }
   if(track2Playing){
  
      fill(236, 237, 7, 150);
     ellipse(deck1x, deck1y, 80, 80);
     
      fill(0, 200, 220, 150);
      ellipse(vinylBx, vinylBy, 20, 20);
      noFill();
  }
   if(track3Playing){
  
     fill(50, 0, 250, 100);
     ellipse(deck1x, deck1y, 80, 80);
     
      fill(0, 200, 220, 150);
      ellipse(vinylCx, vinylCy, 20, 20);
      noFill();
  }
  
  /*****visualizer button power signals*****/
   if(vis1){
  
     fill(50, 255, 50, 100);
     noStroke();
     rect(vis1x-vidButton.width/4+4, vis1y-vidButton.height/12+3, 55,20 );
     
      noFill();
  }
   if(vis2){
  
     fill(50, 255, 50, 100);
     noStroke();
     rect(vis2x-vidButton.width/4+4, vis2y-vidButton.height/12+3, 55,20 );
     
      noFill();
     // colorMode(HSB);
  }
   if(vis3){
  
     fill(50, 255, 50, 100);
     noStroke();
     rect(vis3x-vidButton.width/4+4, vis3y-vidButton.height/12+3, 55,20 );
     
      noFill();
   //   colorMode(HSB);
  }
  if(rgb){
     fill(166, 245, 20, 100);
     noStroke();
     rect(rgbx-vidButton.width/4+4, rgby-vidButton.height/12+3, 55,20 );
      noFill();
      
  }else{
      fill(245, 123, 20, 100);
     noStroke();
     rect(rgbx-vidButton.width/4+4, rgby-vidButton.height/12+3, 55,20 );
     
      noFill();
  }
  /*****power button power signal*****/
  if(deck1Playing){
  
     fill(50, 255, 50, 100);
     noStroke();
     rect(playx-vidButton.width/4+8, playy-playButton.height/15-2, 45,55 );
     
      noFill();
  }
  else{
    
     fill(255, 0, 0, 60);
     noStroke();
     rect(playx-vidButton.width/4+8, playy-playButton.height/15-2, 45,55 );
     
      noFill();
  
  }
  
  
  colorMode(HSB);
}


void mouseClicked()
{

  //if (mouseX > (width/2)-recordPlayer[0].width-(margin*10) && mouseX < recordPlayer[0].width+((width/2)-recordPlayer[0].width-(margin*10)) && mouseY>TV.height+margin && mouseY <TV.height+margin + recordPlayer[0].height) {
  if(dist(mouseX, mouseY, deck1x, deck1y) < recordPlayer[0].width/2){
    
    deck1Playing = !deck1Playing;
  }
  
 /*******power button click*************/
  if(dist(mouseX, mouseY, playx, playy)< playButton.width/12){
   track1Playing=true;
      track2Playing=false;
      track3Playing=false;
      deck1Playing = !deck1Playing;
           track = "/DJApp/cb2.mp3"; 
 vis.changeTrack(track);

reset=!reset;
  voly=597.5;
  slidery=597.5;
        colorSliderx= volx+30-70;
        colAdjust=1;
        volAdjust=map(voly,545,650,0,2);
        speedAdjust=map(slidery,545,650,0,2);

//reset 
  //slidery=597.5;
  //voly=597.5;
  //colorSliderx= volx+30-70;

  }
  
  /*****Reset Button Click*****/
    if(dist(mouseX, mouseY, resetx, resety)< resetButton.width/2){
    
     voly=597.5;
  slidery=597.5;
        colorSliderx= volx+30-70;
        colAdjust=1;
        volAdjust=map(voly,545,650,0,2);
        speedAdjust=map(slidery,545,650,0,2);
    
    }

  
  
 /******visualizer buttons**********/
  
    if(dist(mouseX, mouseY, vis1x, vis1y)< vidButton.width/4){
      vis1 = !vis1;
   
  }
  
   if(dist(mouseX, mouseY, vis2x, vis2y)< vidButton.width/4){
      vis2 = !vis2;
      //vis1=false;
   
  }
  
   if(dist(mouseX, mouseY, vis3x, vis3y)< vidButton.width/4){
      vis3 = !vis3;
      //vis1=false;
   
  }
  
  /****rgb button***/
   
   if(dist(mouseX, mouseY, rgbx, rgby)< vidButton.width/4){
      rgb = !rgb;
       vis.switchColorMode();
   
  }
 
  
/*********track select click*************/

    if(dist(mouseX, mouseY, vinylAx, vinylAy)< vinyl.width/2){
      track1Playing=true;
      track2Playing=false;
      track3Playing=false;
      track = "/DJApp/cb2.mp3";
 vis.changeTrack(track);
  }
  
    //select track 2
    if(dist(mouseX, mouseY, vinylBx, vinylBy)< vinyl.width/2){
        track1Playing=false;
      track2Playing=true;
      track3Playing=false;
      track = "/DJApp/angels.mp3";
 vis.changeTrack(track);
  }
  
      //select track 3
    if(dist(mouseX, mouseY, vinylCx, vinylCy)< vinyl.width/2){
    track1Playing=false;
    track2Playing=false;
    track3Playing=true;
      track = "/DJApp/clarity.mp3";
 vis.changeTrack(track);
  }
  
  /************deckPlaying check************/

  if (deck1Playing) {
    player1.play();
  } 
  else {
    vis.stopPlay();
    
  }
  
}

void mouseDragged() {
    
/******Slider changes***********/

/****speed slider*****/
 if((mouseY>slidery || mouseY<slidery) && (mouseY>=545 && mouseY<=650) && (mouseX>=757 && mouseX<=795) ) {
 
   slidery=mouseY;
   
   speedAdjust=map(slidery,545,650,0,2);

 }
 
 /****volume slider****/
 if((mouseY>voly || mouseY<voly) && (mouseY>=545 && mouseY<=650) && (mouseX>=688 && mouseX<=721) ) {
 
   voly=mouseY;
   
  volAdjust=map(voly,545,650,0,2);

 }
 
  /****colour slider****/
 if((mouseX>colorSliderx || mouseX<colorSliderx) && (mouseX>=width/2-10 && mouseX<=width/2+140) && (mouseY>=675 && mouseY<=710) ) {
 
   colorSliderx=mouseX;
   
  colAdjust=map(colorSliderx,640,710,0,255);

 }
 

}
class Vis1
{
 boolean switchCol=false;
 
  int colAdj=1;
//////////for vis1
float time=0;
Maxim maxim;
AudioPlayer player;
int counter=0;
int w=512;
int h=512;
float rotationSpeed = 1;
float volPower=0;

////////////for vis2

float rotation, spacing, radius, magnify;
int elements=110;

class Shoot{
  float offset=70;

  

void shoot(int colAdj, int rotationSpeed, int i){

 fill(0,255,255, 100);
 if(colAdj>20){
     //multiplier=colAdj*i/20;
    int colAdjs=(colAdj/60);
     //fill(0,255*colAdjs,255, 100);
      fill(i*colAdjs*(2*rotationSpeed)*(colAdjs/50),255,255, 150);
   }
  ellipse(offset+sin(20)*2,offset,100,100);
  
  noFill();
  
  offset=offset+0.25;


}
}

  
 // println(offset);
  

  
 Shoot[] shoots = new Shoot[50000];

////////////////////////////////////////SETUP1
void visSetup(String track){
//size(512,512);
frameRate(65);

//sound
maxim = new Maxim(this);

player= maxim.loadFile(track);
player.setLooping(true);
 player.setAnalysing(true);
//colorMode(HSB);
 
 //make array of shooters
 for(int i; i<shoots.length;i++)
 {
   shoots[i] = new Shoot();
 }
 
 
}
/////////////////////////////

////////////////////////////////////////SETUP2
void visSetup2(String track){
rotation=2;
spacing=TWO_PI/elements;
radius=5;
magnify=2;

//sound
maxim = new Maxim(this);

player= maxim.loadFile(track);
player.setLooping(true);
 player.setAnalysing(true);

//switchColorMode();

}

void changeTrack(String track){

  player.stop();
  player= maxim.loadFile(track);
  player.setLooping(true);
 player.setAnalysing(true);


}
//////////////////////////SETUP3


////////////////////////DRAW1
void visDraw(){
    
  //background(0);
  pushMatrix();
  
  translate(width*0.5, h*0.5);//translate all drawing to middle of the screen
  noFill();
      
   fill(0, 134, 247, 60);
   ellipse(0,0,280,280);
   noFill();
       
   fill(0);
   ellipse(0,0,270,270);
   noFill();


   fill(0, 134, 247, 250);
   ellipse(0,0,50,50);
   noFill();
   
   rotator();
   
   popMatrix();
  
  }
  
  ////////////////////DRAW2
  void visDraw2(){
 time=time+0.001;
rotation+=0.01;
radius+=0.01;
magnify+=0.1;

    player.play();
      
    float power=player.getAveragePower();
    
    pushMatrix();
    //currentColorMode=colorMode(HSB);
  //background(0);

if(switchCol==true){
  colorMode(RGB);
  }

  translate(width*0.5, h*0.5);//translate all drawing to middle of the screen

  noFill();

 for(int i=0;i<elements;i++){
    float speed=rotationSpeed;
     speedCheck();
     rotationSpeed=speed;
    
     float vol=pow+0.0001;
     volCheck();
     pow=vol;
      
     power=-power*vol;
   
   
   stroke(i*(2*rotationSpeed),255,255);
   if(colAdj>20){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      stroke(i*colAdjs*(2*rotationSpeed)*(colAdjs/50),255,255);
   }
   else{   stroke(i*(2*rotationSpeed),255,255);}
   pushMatrix();
   rotate(spacing* i * (rotation*rotationSpeed));
   
   translate((sin(spacing* i * power) * magnify)*vol, 0);
   
   ellipse(0,0,i*4,i*4);
   
   popMatrix();
 
 }popMatrix();
}

//////////////////DRAW3
void visDraw3(){

   colorMode(RGB);
  if(switchCol==true){
  colorMode(HSB);
  }
 
pushMatrix(); 
  
  time=time+0.0009;
  player.play();

  float power=player.getAveragePower();
  power=-power*20;

  //background(0);
  translate(width*0.5, h*0.5);//translate all drawing to middle of the screen
  noFill();
  
 
  for (int i=0;i<40;i++)
  {
     float speed=rotationSpeed;
     speedCheck();
     rotationSpeed=speed;
    
    rotate(time*rotationSpeed);
    translate(power*i,-power*i);
   // rect(i,i,i*2,i*2);
   
   //squashed central pattern
   stroke(16, 0, 170);
   rect(i,i,i*5,i*5);
   stroke(0);          
    //yellow ellipses
    fill(0, 134, 247, 80);
    if (colAdj>20){
        fill(0, colAdj, 247-(colAdj/2), 80);
    }
       rect(i*20,i*20,i*2,i*2);
       noFill();
       
       //yellow twin ellipses
    fill(0, 134, 247, 80);
    if (colAdj>20){
        fill(colAdj, 134-colAdj, 247-(colAdj/2), 80);
    }
       rect(i*12,i*20,i*2,i*2);
       noFill();
       
        //yellow twin ellipses 2
    fill(0, 134, 247, 80);
     if (colAdj>20){
        fill(colAdj, 0, 247-(colAdj), 80);
    }
       rect(i*10,i*16,i,i);
       noFill();
    
    //blue squares   
       fill(28, 81, 234, 50);
       if (colAdj>20){
        fill(28+(colAdj/3), 81-(colAdj/8), 234-(colAdj/5), 80);
    }
       rect(i*5,i*5,i*2,i*2);
       noFill();
       
       //blue squares   
       fill(28, 81, 234, 50);
       if (colAdj>20){
        fill(28+(colAdj/1.5), 81+(colAdj/3), 234-(colAdj/2), 80);
    }
       
       rect(i*5,i*5,i*5,i*5);
       noFill();
       
  }
  popMatrix();
  colorMode(HSB);
}
  
  /****Utility methods*****/
  
  void switchColorMode(){
    switchCol=!switchCol;
  
  }
  
  
  void play(){
      player.play();

  }
  
   void stopPlay(){
      player.stop();

  }
  
  void speedCheck(){
    if(speed>1.2)
     speed=speed+0.2;
    
     else if(speed>1.4)
     speed=speed+0.4;
     
     else if(speed>1.6)
     speed=speed+0.6;
     
     else if (speed>1.7)
     speed=speed+2;
     
     else if (speed>1.8)
     speed=speed+4;
  }
  
  
  void speed(int speedAdjust){
    player.speed(speedAdjust);
  
  }
  
  
  void volCheck(){
  
  if(vol>1.2)
     vol=vol+0.2;
    
     else if(vol>1.4)
     vol=vol+0.4;
     
     else if(vol>1.6)
     vol=vol+0.6;
     
     else if (speed>1.7)
     vol=vol+2;
     
     else if (speed>1.8)
     vol=vol+4;
  }
  
  void vol(int volAdjust){
    player.volume(volAdjust);
  }
  
  void col(int colAdjust){
    
     colAdj= colAdjust;
  }
  
  void setRotationSpeed(float speed){
  
     rotationSpeed= speed;
  
  }
  
  void setPow(float vol){
  
    pow=vol;
  }
  
 /////////////////////////////////
 void rotator(){
    time=time+0.0009;
    play();
    float power=player.getAveragePower();
    power=-power*20;
   
   if(switchCol==true){
  colorMode(RGB);
  }
  
   for (int i=0;i<40;i++)
   {
     float speed=rotationSpeed;
     speedCheck();
     rotationSpeed=speed;
     rotate(time*rotationSpeed);
      
     float vol=pow;
     volCheck();
     pow=vol;
      
     power=-power*vol;
    
   
    //squashed central pattern
    
   stroke(16, 0, 170);
    
    if(colAdj>20){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      stroke(i*colAdjs*(2*rotationSpeed)*(colAdjs/50),255,255);
   }
    
   ellipse(i,i,i*5,i*5);
   stroke(i, 255, i);       
 
    if(colAdj>20){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      stroke(i*colAdjs*(2*rotationSpeed)*(colAdjs/50),255,255);
   }   
   
   //yellow ellipses
   fill(0, 134*rotationSpeed, 247, 80);
   
     if(colAdj>200){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      fill(i*colAdjs*(10*rotationSpeed)*(colAdjs/50),255,255);
   }   
   
   ellipse(i*20,i*20,i*2,i*2);
   noFill();
       boom=power*2;
   //yellow twin ellipses
   fill(0, 134, 247, 80*boom);
      if(colAdj>200){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      fill(i*colAdjs*(10*rotationSpeed)*(colAdjs/50),255,255, 70);
   }   
    
   
   ellipse(i*12,i*20,i*2,i*2);
   noFill();
       
       
   //yellow twin ellipses 2
   fill(0, 134, 150, 90*power);
       if(colAdj>200){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      fill(i*colAdjs*(10*rotationSpeed)*(colAdjs/50),255,255, 50*(power*2));
   }   
   ellipse(i*10,i*16,i,i);
   noFill();
    
   //blue squares   
   fill(28, 81, 234, 50*power*speed*2);
      if(colAdj>200){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      fill(i*colAdjs*(10*rotationSpeed)*(colAdjs/50),255,255, 110*power);
   }   
   ellipse(i*power,i*5,i*2,i*2);
   noFill();
       
   //blue squares   
   fill(28, 81*power, 234, 50);
   if(colAdj>200){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/205);
     
      fill(i*colAdjs*(2*rotationSpeed),140,150, 50);
   }
   ellipse(i*5,i*5,i*5,i*5);
   noFill();
       
       
       
       //change power to 4 for mac miller songs
       //power at 1.1 for cb songs
    if(power>1.1){
      
    //  println(x);
     
      
      stroke(0,255,255, 150);
       if(colAdj>200){
     //multiplier=colAdj*i/20;
     colAdjs=(colAdj/90);
     
      stroke(i*colAdjs*(10*rotationSpeed)*(colAdjs/50),255,255);
   }   
      //fill(0,255,255,60);
      //  ellipse(0,0,300, 300);
        rect(0,0,20,20);
        rect(0,0,10,10);
       
 //rect(width+20, height+20, width, height);
        rect(0-width+20, 0-h+20, width, h);
counter+=1/500;
      
      x=(int)counter;
      shoots[x].shoot(colAdj, rotationSpeed, i);
    }
   
   
   }
}
}
//The MIT License (MIT)

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


PImage [] loadImages(String stub, String extension, int numImages)
{
  PImage [] images = new PImage[0];
  for(int i =0; i < numImages; i++)
  {
    PImage img = loadImage(stub+i+extension);
    if(img != null)
    {
      images = (PImage [])append(images,img);
    }
    else
    {
      break;
    }
  }
  return images;
}


