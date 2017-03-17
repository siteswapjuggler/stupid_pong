import oscP5.*;
import netP5.*;
OscP5  oscP5;

Score   score;
Paddle  right, left;

boolean         test  = true;
boolean         pause = false;
ArrayList<Ball> balls;
float           offset, pixSize,scale;

void setup() {
  fullScreen();
  //size(800, 600);
  frameRate(60);
  noStroke();
 
  scale   = width/800.;
  pixSize = width/80.;
  offset  = 3 * pixSize;

  score = new Score();
  left  = new Paddle(true);
  right = new Paddle(false);

  oscP5 = new OscP5(this, 6000);

  balls = new ArrayList<Ball>();
  balls.add(new Ball());
}

void draw() {
  background(test?0:255);
  fill(test?255:0);

  if (!pause) {
    right.update();
    left.update();
    for (int i =0; i<balls.size(); i++) {
      Ball b = balls.get(i);
      b.update();
    }
  }

  netDraw();
  sideDraw();
  right.draw();
  left.draw();
  score.draw();
  for (int i =0; i<balls.size(); i++) {
    Ball b = balls.get(i);
    b.draw();
  }
}