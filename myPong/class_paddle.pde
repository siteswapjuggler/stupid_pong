class Paddle {
  int dir;                    // Paddle speed in px/frame
  boolean side;               // Right or left paddle
  float   pos, speed, size;   // Position and paddle size
  boolean key_up, key_down;    // Command states

  // Contructor
  Paddle(boolean _side) {
    side  = _side;
    pos   = height/2.;
    size  = 8;
    dir   = 0;
    speed = 5*scale;
  }

  // Custom method for drawing the object
  void update() {
    if (key_up ^ key_down) {
      dir = key_up ? -1 : 1;
    } else {
      dir = 0;
    }
    pos += dir*speed;
  }

  // OSC Control
  void setVal(float v) {
    pos = map(v, 0., 1., height, 0.);
  }

  void setSize(float v) {
    size = (int)v;
  }

  void reduceSize() {
    size--;
  }

  // Custom method for drawing the object
  void draw() {
    float hmin = size*pixSize/2.;
    float hmax = height - size*pixSize/2.;
    pos  = constrain(pos,hmin,hmax);
    size = constrain(size, 0, 80);
    rect(side?0+offset:width-offset-pixSize, pos-size*pixSize/2., pixSize, size*pixSize);
  }
}