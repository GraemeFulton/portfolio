
Maxim maxim;
AudioPlayer player;

boolean ON = false;

int value = 0;

float rotation, spacing, radius, magnify;

//clock setup
int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

//record background
PImage [] recordPlayer;
float rotateDeck1 = 0;
int deck1x, deck1y;
float currentFrame = 0;
int margin = width/40;


//create objects before draw loop
Vizualizer viz = new Vizualizer();
Clock clock = new Clock();
PowerBtn powerBtn = new PowerBtn();

void setup(){
  
  size(400, 400);
  frameRate(100);
  imageMode(CENTER);
  //record player background
  recordPlayer = loadImages("black-record_", ".png", 36);
  //musix
  maxim= new Maxim(this);
  player = maxim.loadFile("/MusicClock/01.m4a");
  //player = maxim.loadFile("/MusicClock/01.ogg");
  player.setLooping(true);
  player.setAnalysing(true);
  player.speed(10);

  //make da clock
  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;
  
  
  cx = width / 2;
  cy = height / 2;
 

}



void mouseDragged() 
{
  value = value + 5;
  if (value > 255) {
  player.play();
  }
}

void mouseClicked()
{
   powerBtn.togglePower();
}

//draw loop
void draw(){

  imageMode(CENTER);

//get da power
  if(player.isPlaying()==true){
  int power = player.getAveragePower();
  }
  else{
    int power = 0;
  }
      background(40);

  
  clock.start(power);
   
  powerBtn.create();



}

class Vizualizer{

  void start(int power){
 
    noFill();   
      stroke(255);
     beginShape();
  
    
    bump = power*500;
       if(bump>0 && bump<50)bump=0;
                      if(bump>100){stroke(0,0,180);}

       
   int offsetA = 20;
   int offsetB =30;
   
   int inc= 0;
   
   //IF SWITCH ON
   if(ON==true){
         vertex(20, height/2); // first point

   for(int i =0; i<9;i++){

     if(i==1){inc=5;}
     if(i==2){inc=10;}
     if(i==3){inc=20;}
     if(i==4){inc=10;}
     if(i==5){inc=5;}
     if(i==6){inc=10;}
     if(i==7){inc=20;}
     if(i==8){inc=10;}
     if(i==9){inc=0;}

          bump=bump-inc;

           if(bump>0 && bump<50)bump=0;

     bezierVertex(offsetA, height/2+bump, offsetB, height/2+bump, offsetB, height/2);
    offsetA+=15;
       bezierVertex(offsetB, height/2-bump, offsetA, height/2-bump, offsetA, height/2);
    offsetB+=15;
   }
   
   
          bezierVertex(150, height/2, 170, height/2, 175, height/2);
    
    
          //AM      
          bezierVertex(175, height/2-50, 190, height/2, 190, height/2);
          bezierVertex(190, height/2, 195, height/2+10, 195, height/2);

          //THE M!
          bezierVertex(195, height/2-50, 210, height/2, 210, height/2);
                    bezierVertex(212, height/2+2, 212, height/2, 212, height/2);
          bezierVertex(222, height/2-50, 220, height/2, 220, height/2);
          bezierVertex(220, height/2, 220, height/2, 245, height/2);
   
          
          

offsetA=245;
offsetB=255;
for(int i =0; i<9;i++){
     
     bump=bump+inc;
     if(i==1){inc=0;}
     if(i==2){inc=10;}
     if(i==3){inc=20;}
     if(i==4){inc=10;}
     if(i==5){inc=5;}
     if(i==6){inc=10;}
     if(i==7){inc=20;}
     if(i==8){inc=10;}
     if(i==9){inc=0;}
           if(bump>0 && bump<-40)bump=0;
           
     bezierVertex(offsetA, height/2+bump, offsetB, height/2+bump, offsetB, height/2);
    offsetA+=15;
       bezierVertex(offsetB, height/2-bump, offsetA, height/2-bump, offsetA, height/2);
    offsetB+=15;
}
   }
   else{
    //AM      
             vertex(170, height/2); // first point

        bezierVertex(180, height/2, 180, height/2, 180, height/2);

          bezierVertex(175, height/2-50, 190, height/2, 190, height/2);
          bezierVertex(190, height/2, 195, height/2+10, 195, height/2);

          //THE M!
          bezierVertex(195, height/2-50, 210, height/2, 210, height/2);
          bezierVertex(212, height/2+2, 212, height/2, 212, height/2);
          bezierVertex(222, height/2-50, 220, height/2, 220, height/2);
          bezierVertex(220, height/2, 220, height/2, 230, height/2);
          
          
          
   }
      

    endShape();
  
  }
  


}


class Clock{

  void start(int power){
  // Draw the clock background
  fill(10);
  noStroke();
   ellipse(cx, cy, clockDiameter, clockDiameter);
  
  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  
        drawRecord();

        viz.start(power);

  // Draw the hands of the clock
 // stroke(180+bump);
  strokeWeight(2+(bump/3));
  if(power!=0){
  line(cx, cy, cx + cos(s) * secondsRadius-(power*222), cy + sin(s) * secondsRadius)*(power*222);
  }
  else{
     line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  }
  //minute and hr
  stroke(180);
  strokeWeight(4+bump/5);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  strokeWeight(8);
  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
  
  // Draw the minute dots that go round the clockface
  strokeWeight(2+bump/10);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
     stroke(180);
    float angle = radians(a);
    //clock face animating with power:
    stroke(250,0,0);
    float x = cx + cos(angle) * secondsRadius*(power);
    float y = cy + sin(angle) * secondsRadius*(power);
    vertex(x, y);
    //static clock face:
    stroke(200);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy + sin(angle) * secondsRadius;
    vertex(x, y);
  }
  endShape();
    strokeWeight(2);

  }
  
  void drawRecord(){
  
  deck1x = (width)-recordPlayer[0].width+12;
  deck1y = (height/4)+recordPlayer[0].height/2-12;
   if (rotateDeck1 >= recordPlayer.length) {

      rotateDeck1 = 0;
    }
    if(ON==true){
 image(recordPlayer[(int) rotateDeck1], deck1x, deck1y, recordPlayer[0].width*1.8, recordPlayer[0].height*1.8);

    currentFrame= currentFrame+1;
    rotateDeck1 += 1;
    }
    else{
     image(recordPlayer[0], deck1x, deck1y, recordPlayer[0].width*1.8, recordPlayer[0].height*1.8);

    }
  
  }

}


class PowerBtn{
  //power button  
  void create(){
    
      fill(0);
      noStroke();
      ellipse(25, 25, 30, 30);
      if(ON==true){
        fill(20,142,7);
        ellipse(25, 25,15, 15);
        player.play();
      }
      else{
       fill(216,28,28);
        ellipse(25, 25,15, 15);  
        player.play();
        player.stop();
      }
      fill(117,216,135);
  }
  
  
  void togglePower(){
    
    if(dist(mouseX, mouseY, 30, 30) < 15){
      if(ON == true){
        ON=false;
      }
      else if(ON==false){
        ON=true;
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
    PImage img = loadImage('/MusicClock/'+stub+i+extension);
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

