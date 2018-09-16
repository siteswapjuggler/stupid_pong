void playHit() {
  if ( hit.position() >= 0 )
  {
    hit.rewind();
    hit.play();
  }
  else
  {
    hit.play();
  }
}

void playLoose() {
  if ( loose.position() >= 0 )
  {
    loose.rewind();
    loose.play();
  }
  else
  {
    loose.play();
  }
}

void playBounce() {
  if ( bounce.position() >= 0 )
  {
    bounce.rewind();
    bounce.play();
  }
  else
  {
    bounce.play();
  }
}