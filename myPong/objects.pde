class Ball {
  PVector pos, speed;
  float velocity;
  int   size;
  
  Ball() {
    size     = (int)(pixSize);
    velocity = 4*scale;
    service(random(1)>=0.5);
  }

  void service(boolean side) {
    pos   = new PVector(width/2., height/2.);
    float angle = (side ? 35+random(110) : -35-random(110)) * TWO_PI/360.;
    speed = new PVector(velocity*sin(angle), velocity*cos(angle));
  }

  void update() {
    pos.add(speed);

    //bounce up
    float hmin = size/2.;
    if (pos.y <= hmin) {
      speed.y *= -1;
      pos.y   = 2*hmin - pos.y;
    }

    //bounce down
    float hmax = height - size/2.;
    if (pos.y >= hmax) {
      speed.y *= -1;
      pos.y   = 2*hmax - pos.y;
    }

    //bounce left
    float wmin = offset + pixSize + size/2.;
    if (pos.x <= wmin && pos.x > wmin - pixSize) {
      float psize = left.size*pixSize/2.;
      if ((pos.y + size/2. > left.pos - psize)&&(pos.y - size/2. < left.pos + psize)) {
        speed.x *= -1;
        pos.x    = 2*wmin - pos.x;
      }
    }

    //bounce right
    float wmax = width - offset - pixSize - size/2.;
    if (pos.x >= wmax && pos.x < wmax + pixSize) {
      float psize = right.size*pixSize/2.;
      if ((pos.y + size/2. > right.pos - psize)&&(pos.y - size/2. < right.pos + psize)) {
        speed.x *= -1;
        pos.x    = 2*wmax - pos.x;
      }
    }        

    //point left
    if (pos.x + size/2. < - 200) {
      score.right++;
      service(true);
    }

    //point right
    if (pos.x - size/2. > width + 200) {
      score.left++;
      service(false);
    }
  }

  void draw() {
    rect(pos.x-size/2., pos.y-size/2., size, size);
  }
  
  void setSize(float v) {
    size     = (int)(v*pixSize);
  }        
}

class Paddle {
  int dir;                  // Paddle speed in px/frame
  boolean side;             // Right or left paddle
  float pos, speed, size;   // Position and paddle size
  boolean key_up,key_down;  // Command states

  // Contructor
  Paddle(boolean _side) {
    side  = _side;
    pos   = height/2.;
    size  = 8;
    dir   = 0;
    speed = 5*scale;
    println(speed);
  }

  // Custom method for drawing the object
  void update() {
    if (key_up ^ key_down) {
      dir = key_up ? -1 : 1;
    }
    else {
      dir = 0;
    }
    pos += dir*speed;
    float hmin = size*pixSize/2.;
    float hmax = height - size*pixSize/2.;
    if (pos < hmin) pos = hmin;
    if (pos > hmax) pos = hmax;
  }

  // OSC Control
  void setVal(float v) {
    pos = map(v,0.,1.,height,0.);
  }

  // Custom method for drawing the object
  void draw() {
    if (!side) {
      rect(width-offset-4*pixSize,pos-size*pixSize/2., pixSize*2, pixSize*2);
    }  
    rect(side?0+offset:width-offset-pixSize, pos-size*pixSize/2., pixSize, size*pixSize);
  }
}

class Score {
  int right, left;

  Score() {
    right = 0;
    left  = 0;
  }

  void draw() {
    textSize(60*scale);
    textAlign(CENTER);
    text(left, width/4., 60*scale+offset); 
    text(right, 3*width/4., 60*scale+offset);
  }
}

void netDraw() {
  for (int i = 0; i < round(height/pixSize); i++) {
    int v = i%4;
    if (v == 1) {
      rect((width-pixSize)/2., i*pixSize, pixSize, 2*pixSize);
    }
  }
}

void sideDraw() {
  rect(0,0,2*pixSize,height);
  rect(width-2*pixSize,0,width,height);
}