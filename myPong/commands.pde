void keyPressed() {
  Paddle J1 = pads.get(0);
  Paddle J2 = pads.get(1);

  int v = keyCode;
  if (v == 65) {
    //a left paddle up
    if (!J1.key_up) J1.key_up = true;
  } else if (v == 81) {
    //q left paddle down
    if (!J1.key_down) J1.key_down= true;
  } else if (v == 80) {
    //p right paddle up
    if (!J2.key_up) J2.key_up = true;
  } else if (v == 77) {
    //m right paddle down
    if (!J2.key_down) J2.key_down = true;
  } else if (v == 32) {
    //space to pause
    pauseGame();
  } else if (v == 84) {
    //t to test effects
    text = "KING PONG !";
    promptText = true;
  }
}

void keyReleased() {
  Paddle J1 = pads.get(0);
  Paddle J2 = pads.get(1);

  int v = keyCode;
  if (v == 65) {
    //a left paddle up
    if (J1.key_up) J1.key_up = false;
  } else if (v == 81) {
    //q left paddle down
    if (J1.key_down) J1.key_down = false;
  } else if (v == 80) {
    //p right paddle up
    if (J2.key_up) J2.key_up = false;
  } else if (v == 77) {
    //m right paddle down
    if (J2.key_down) J2.key_down = false;
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/paddle/move")) {
    Paddle p = pads.get(theOscMessage.get(0).intValue());
    p.setVal(theOscMessage.get(1).floatValue());
  }

  if (theOscMessage.checkAddrPattern("/paddle/size")) {
    Paddle p = pads.get(theOscMessage.get(0).intValue());
    p.setSize(theOscMessage.get(1).intValue());
  }

  if (theOscMessage.checkAddrPattern("/ball/size")) {
    for (int i =0; i<balls.size(); i++) {
      Ball b = balls.get(i);
      b.setSize(theOscMessage.get(0).floatValue());
    }
  }

  if (theOscMessage.checkAddrPattern("/paddle/+1")) {
    pads.add(new Paddle(theOscMessage.get(0).intValue() != 0));
  }  

  if (theOscMessage.checkAddrPattern("/boomerang")) {
    for (int i =0; i<balls.size(); i++) {
      Ball b = balls.get(i);
      b.speed.rotate(PI);
    }
  }  


  if (theOscMessage.checkAddrPattern("/paddle/2vs2")) {
    pads.add(new Paddle(true));
    pads.add(new Paddle(false));
  }  

  if (theOscMessage.checkAddrPattern("/paddle/reset")) {
    while (pads.size() > 2) {
      pads.remove(pads.size()-1);
      pads.trimToSize();
    }
  }  

  if (theOscMessage.checkAddrPattern("/ball/add")) {
    balls.add(new Ball(theOscMessage.get(0).intValue()));
  }

  if (theOscMessage.checkAddrPattern("/ball/speed")) {
    for (int i =0; i<balls.size(); i++) {
      Ball b = balls.get(i);
      b.speed.mult(theOscMessage.get(0).floatValue());
    }
    speedMult = theOscMessage.get(0).floatValue();
    speedMult = constrain(speedMult, 1., 100.);
  }


  if (theOscMessage.checkAddrPattern("/ball/suppr")) {
    if (balls.size() > 1) {
      balls.remove(balls.size()-1);
      balls.trimToSize();
    }
  }

  if (theOscMessage.checkAddrPattern("/reset")) {
    startGame();
  }

  if (theOscMessage.checkAddrPattern("/message")) {
    text = theOscMessage.get(0).stringValue();
    promptText = true;
  }

  if (theOscMessage.checkAddrPattern("/net")) {
    solidNet = theOscMessage.get(0).intValue() == 1;
  }

  if (theOscMessage.checkAddrPattern("/invert")) {
    invert=invert?false:true;
  }

  if (theOscMessage.checkAddrPattern("/ghost")) {
    ghost=theOscMessage.get(0).intValue() == 1;
  }

  if (theOscMessage.checkAddrPattern("/pause")) {
    pauseGame();
  }
}