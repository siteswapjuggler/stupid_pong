void pauseGame() {
  pause = pause ? false : true;
}

void resetScore() {
  score.right = 0;
  score.left  = 0;
}

void startGame() {
  pause = false;
  resetScore();
}

void resetPads(boolean side) {
  for (int i =0; i<pads.size(); i++) {
    Paddle p = pads.get(i);
    if (p.side == side) p.size = 8;
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
  if (!solidNet) { 
    for (int i = 0; i < round(height/pixSize); i++) {
      int v = i%5;
      if (v == 1) {
        rect((width-pixSize)/2., i*pixSize, pixSize, 2*pixSize);
      }
    }
  } else {
    rect((width-pixSize)/2., 0, pixSize, height);
  }
}