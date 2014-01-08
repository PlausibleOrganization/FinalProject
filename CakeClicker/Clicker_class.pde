class Clicker {
  PVector loc;
  int size;

  Clicker() {
    loc = new PVector(width-200, 0);
    size = 200;
  }

  void update() {
  }
  void display() {
    fill(100);
    imageMode(CORNER);
    if (button(loc.x, loc.y, size, size)) {
      image(cake, loc.x+size*.1, loc.y+size*.1, size*.8, size*.8);
    } else {
      image(cake, loc.x, loc.y, size, size);
    }
  }
}

