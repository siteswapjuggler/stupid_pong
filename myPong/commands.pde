void keyPressed() {
  int v = keyCode;
  if (v == 65) {
    //a left paddle up
    if (!left.key_up) left.key_up = true;
  }
  else if (v == 81) {
    //q left paddle down
    if (!left.key_down) left.key_down= true;
  }
  else if (v == 80) {
    //p right paddle up
    if (!right.key_up) right.key_up = true;
  }
  else if (v == 77) {
    //m right paddle down
    if (!right.key_down) right.key_down = true;
  }
  else if (v == 32) {
    //space to pause
    pause = pause ? false : true;
  }
}

void keyReleased() {
  int v = keyCode;
  if (v == 65) {
    //a left paddle up
    if (left.key_up) left.key_up = false;
  }
  else if (v == 81) {
    //q left paddle down
    if (left.key_down) left.key_down = false;
  }
  else if (v == 80) {
    //p right paddle up
    if (right.key_up) right.key_up = false;
  }
  else if (v == 77) {
    //m right paddle down
    if (right.key_down) right.key_down = false;
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/left")) {
     left.setVal(theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/right")) {
     right.setVal(theOscMessage.get(0).floatValue());
  }
 if (theOscMessage.checkAddrPattern("/ball/size")) {
    for (int i =0; i<balls.size(); i++) {
      Ball b = balls.get(i);
      b.setSize(theOscMessage.get(0).floatValue());
    }
  }
  if (theOscMessage.checkAddrPattern("/ball/add")) {
     balls.add(new Ball());
  }
  if (theOscMessage.checkAddrPattern("/ball/suppr")) {
     balls.remove(balls.size()-1);
     balls.trimToSize();
  }
 if (theOscMessage.checkAddrPattern("/invert")) {
     test=test?false:true;
  }  
 /*
 if (theOscMessage.checkAddrPattern("/ball")) {
     ball.setVal(theOscMessage.get(0).floatValue());
  }

  if (theOscMessage.checkAddrPattern("/supp")) {
     supp.setVal(theOscMessage.get(0).floatValue());
  }
 if (theOscMessage.checkAddrPattern("/paddle")) {
     ball.setVal(theOscMessage.get(0).floatValue());
  }
*/
}