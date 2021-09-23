// implementation of visuals for pixel-mapping. 
//Inspired by the ArrayListClass example from https://processing.org/examples/arraylistclass.html


import themidibus.*;
MidiBus myBus;
OPC opc;
PImage dot;

//color bg = color(255, 0, 0);
int red = 0;
public color colorFill;
int color1;
int color2;
int color3;

long lastTime = 0;
boolean glob = false;

ArrayList<Ball> balls;
int ballWidth = 40;
float[] spread = new float[24];
int i;
int w;
boolean spawnNew = false;

void setup() {
  imageMode(CENTER);
    dot = loadImage("dot.png");

  size(1040, 520,P3D);
noStroke();
  float l = width/24;
  
  lastTime = millis();
  
  MidiBus.list();
  // Connect to input, output
  myBus = new MidiBus(this, 3, 0);
  
//fadecandy
  float spacing = width /24.0;

  opc = new OPC(this, "127.0.0.1", 7890);

  opc.ledGrid8x8(128, width/6, (spacing*8)/2, spacing, 0.5*PI, true, false);

  // Put two more 8x8 grids to the left and to the right of that one.
  opc.ledGrid8x8(64, (width/6)+(spacing*8), (spacing*8)/2, spacing, 0.5*PI, true, false);
  opc.ledGrid8x8(0, width/6 + spacing * 16, (spacing*8)/2, spacing,  0.5*PI, true, false);

  
  
  
  
for (int i = 0; i < spread.length; i++) {
  spread[i] = (i*l)+18;
//line(spread[i],0,spread[i],height);
}

  // Creating an empty Arraylist holding all rain drops
  balls = new ArrayList<Ball>();
  
  // Start by adding one element
  balls.add(new Ball(spread[1], 0, ballWidth));
}

void draw() {
  background(0);
  
  
for (int i = 0; i < spread.length; i++) {
line(spread[i],0,spread[i],height);
}
  // With an array, we say balls.length, with an ArrayList, we say balls.size()
  // The length of an ArrayList is dynamic
  // Notice how we are looping through the ArrayList backwards
  // This is because we are deleting elements from the list  
  for (int i = balls.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    Ball ball = balls.get(i);
    ball.move();
    ball.display2();
    ball.display();
    if (ball.finished()) {
      // Items can be deleted with remove()
      balls.remove(i);
    }
    
  }
   if(spawnNew != glob){
    spawnNew = glob;
      balls.add(new Ball(spread[w], 0, ballWidth));
   }
}
  

/*void mousePressed() {
  // A new ball object is added to the ArrayList (by default to the end)
  w = parseInt(random(20));
  balls.add(new Ball(spread[w], 0, ballWidth));
  print(w);
}*/

void controllerChange(int channel, int number, int value) {
  colorFill = color(color1, color2, color3);
  
  if (value == 1) { 
  spawnNew = true;
  w = parseInt(random(24));
  
 

}

if(value == 50){
  color1 = 255;
  color2 = 255;
  color3 = 255;
}

if(value == 51){
  color1 = 0;
  color2 = 0;
  color3 = 255;
}

if(value == 52){
  color1 = 255;
  color2 = 0;
  color3 = 0;
}

if(value == 53){
  color1 = 0;
  color2 = 255;
  color3 = 0;
}

if(value == 54){
  color1 = 255;
  color2 = 255;
  color3 = 0;
}



println(value);
}




// Simple bouncing ball class

class Ball {
  
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = height;
  
  Ball(float tempX, float tempY, float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
  }
  
    void move() {
    // Add gravity to speed
    speed = 14;
    // Add speed to y location
    y = y + speed;
    // If square reaches the bottom
    // Reverse speed
    
  }
  
  boolean finished() {
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    // Display the circle
    //stroke(0,life);
  fill(colorFill,255);
  ellipse(x,y,w,w);
  
  //image(dot, x, y, w*2, w+180 );
  }
   void display2() {
       fill(colorFill,70);

  ellipse(x,y,w,w+70);
  //image(dot, x, y, w*2, w+180 );
  }
}