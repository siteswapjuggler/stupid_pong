import oscP5.*;
import netP5.*;
OscP5  oscP5;

import ddf.minim.*;
Minim minim;
AudioPlayer loose, bounce, hit;

PFont police;

Score   score;
Paddle  right, left;

boolean            ghost    = false;
boolean            invert   = false;
boolean            pause    = false;
boolean            solidNet = false;
float              speedMult = 1.;

boolean            promptText  = false;
int                promptCount = 0;
String             text = "";

float              highSpeed = 1.1;

ArrayList<Ball>    balls;
ArrayList<Paddle>  pads;
float              offset, pixSize, scale;

void setup() {
  fullScreen();
  //size(800, 600);                 // résolution de l'écran
  frameRate(60);                  // vitesse d'exécution
  noStroke();                     // réglage général uniquement du remplissage

  minim = new Minim(this);
  loose  = minim.loadFile("loose.wav");
  bounce = minim.loadFile("bounce.wav");
  hit    = minim.loadFile("hit.wav");

  scale   = height/600;             // rapport à la taille d'origine
  pixSize = width/80.;              // 80 pixels de large
  offset  = 2 * pixSize;            // marge à droite et à gauche  

  police = loadFont("Symtext-48.vlw");
  textFont(police, 48*scale);
  textAlign(CENTER, CENTER);

  score = new Score();              // gestion des scores

  pads  = new ArrayList<Paddle>();
  pads.add(new Paddle(true));
  pads.add(new Paddle(false));

  balls = new ArrayList<Ball>();
  balls.add(new Ball(0));

  oscP5 = new OscP5(this, 6000);
}

void draw() {
  int base = ghost ? 16 : 255;
  int bg   = invert?255:0;
  int fg   = invert?255-base:base;
  background(bg);
  fill(fg);

  //------------------------------------
  // afficher le hub 
  //------------------------------------
  netDraw();
  score.draw();

  if (!pause) {
    for (int i =0; i<pads.size(); i++) {
      Paddle p = pads.get(i);
      p.update();
    }

    for (int i =0; i<balls.size(); i++) {
      Ball b = balls.get(i);
      b.update();
      if (b.tbk) {
        balls.remove(i);
        balls.trimToSize();
      }
    }
  }

  //------------------------------------
  // on mets à jours les positions
  //------------------------------------

  for (int i =0; i<pads.size(); i++) {
    Paddle p = pads.get(i);
    p.draw();
  }

  for (int i =0; i<balls.size(); i++) {
    Ball b = balls.get(i);
    b.draw();
  }

  //------------------------------------
  // on dessine le hub
  //------------------------------------

  if (promptText) {
    fill(bg, bg, bg, 196);
    rect(0, height-100, width, height-height/100);
    fill(fg);
    text(text, width/2, height - 3 * pixSize);
    if (promptCount++ >= 3*frameRate) {
      promptText = false;
      promptCount = 0;
    }
  }
}