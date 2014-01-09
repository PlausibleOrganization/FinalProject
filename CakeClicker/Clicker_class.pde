class Clicker {
  PVector loc;
  int size;
  boolean clicked;
boolean allowRun;

  Clicker() {
    loc = new PVector(width-200, 50);
    size = 200;
    clicked = false;
    allowRun = true;
  }

  void update() {
    if (button(loc.x, loc.y, size, size) && allowRun) {
      clicked = true;
      allowRun = false;
    } 
    else {
      clicked = false;
    }
  }

  void display() {
    imageMode(CORNER);
    if (button(loc.x, loc.y, size, size)) {
      image(cake, loc.x+size*.1, loc.y+size*.1, size*.8, size*.8);
    } 
    else {
      image(cake, loc.x, loc.y, size, size);
    }
  }
}

