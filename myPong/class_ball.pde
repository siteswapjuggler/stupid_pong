class Ball {
  PVector previous, pos, speed;
  float   velocity;
  int     size;
  boolean tbk;

  Ball(int direction) {
    size     = (int)(pixSize);
    velocity = 5*scale;
    tbk      = false;
    switch (direction) {
      case 0:
        service(random(1)>=0.5);
        break;
      case 1:
        service(true);
        break;
      case 2:
        service(false);
        break;
    }
  }

  void service(boolean side) {
    if (solidNet) side  =  side ? false : true;
    pos   = new PVector(width/2., height/2.);
    pos.x += (side?2:-2)*pixSize;
    float angle = (side ? 35+random(110) : -35-random(110)) * TWO_PI/360.;
    speed = new PVector(velocity*sin(angle), velocity*cos(angle));
    speed.mult(speedMult);
  }

  void update() {
    previous = pos;
    pos.add(speed);

    //-------------------------------------------------------------------------------
    // bounce up and down 
    //-------------------------------------------------------------------------------

    //bounce up
    float hmin = size/2.;
    if (pos.y <= hmin) {
      speed.y *= -1;
      pos.y   = 2*hmin - pos.y;
      playBounce();
    }

    //bounce down
    float hmax = height - size/2.;
    if (pos.y >= hmax) {
      speed.y *= -1;
      pos.y   = 2*hmax - pos.y;
      playBounce();
    }

    //-------------------------------------------------------------------------------
    // solid net 
    //-------------------------------------------------------------------------------

    if (solidNet) {
      float wmin = width/2. + pixSize/2.;
      float wmax = width/2. - pixSize/2.;
      
      if (pos.x <= wmin && speed.x < 0 && previous.x >= wmax) {
        speed.x *= -1;
        pos.x   = 2*wmin - pos.x;
        playBounce();
      }

      if (pos.x >= wmax && speed.x > 0 && previous.x <= wmin) {
        speed.x *= -1;
        pos.x    = 2*wmax - pos.x;
        playBounce();
      }
    }

    //-------------------------------------------------------------------------------
    // check for paddle hit 
    //-------------------------------------------------------------------------------

    for (int i =0; i<pads.size(); i++) {
      Paddle p = pads.get(i);
      boolean hitten = false;

      if (p.size >= 1) {
        //handle left paddles
        if (p.side == true) {
          float wmin = offset + pixSize + size/2.;
          if (pos.x <= wmin && pos.x > wmin - pixSize) {
            float psize = p.size*pixSize/2.;
            if ((pos.y + size/2. > p.pos - psize)&&(pos.y - size/2. < p.pos + psize)) {
              speed.x *= -1;
              pos.x   = 2*wmin - pos.x;
              hitten = true;
            }
          }
        }

        // handle right paddles
        else {
          float wmax = width - offset - pixSize - size/2.;
          if (pos.x >= wmax && pos.x < wmax + pixSize) {
            float psize = p.size*pixSize/2.;
            if ((pos.y + size/2. > p.pos - psize)&&(pos.y - size/2. < p.pos + psize)) {
              speed.x *= -1;
              pos.x    = 2*wmax - pos.x;
              hitten = true;
            }
          }
        }

        if (hitten) {
          playHit();
          speed.mult(1.1);
          if (size > 3*pixSize) p.reduceSize();
          //TODO speed.rotate((HALF_PI/10)*(p.side?1:-1)*(pos.y-p.pos)/pixSize/p.size);
          //println((pos.y-p.pos)/pixSize/p.size);
        }
      }
    }

    //-------------------------------------------------------------------------------
    // update score
    //-------------------------------------------------------------------------------

    boolean newScore = false;

    //score left
    if (pos.x + size/2. < - pixSize) {
      score.right++;
      if (balls.size() == 1) service(true);
      else tbk = true;
      newScore = true;
      resetPads(true);
    }

    //score right
    if (pos.x - size/2. >  width + pixSize) {
      score.left++;
      if (balls.size() == 1) service(false);
      else tbk = true;
      newScore = true;
      resetPads(false);
    }

    if (newScore) {
      playLoose();
      resetSize();
      ghost = false;
    }
  }

  //******************************************************  
  // UTILITIES
  //******************************************************  

  void resetSize() {
    size = (int)pixSize;
  }

  void setSize(float v) {
    size = (int)(v*pixSize);
  }
  
  void setSpeed(float v) {
    speed.mult(v);
  }

  void draw() {
    size = constrain(size, (int)pixSize/4, 40*(int)pixSize);
    speed.limit(20*scale);
    rect(pos.x-size/2., pos.y-size/2., size, size);
  }
}