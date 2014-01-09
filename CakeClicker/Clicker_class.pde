class Clicker {
  PVector loc;
  int size;
  boolean clicked;

  Clicker() {
    loc = new PVector(width-200, 50);
    size = 200;
    clicked = false;
  }

  void update() {
    if (button(loc.x, loc.y, size, size)) {
     clicked = true; 
    } else {
     clicked = false; 
    }
  }
  
  void display() {
    fill(100);
    imageMode(CORNER);
    if (button(loc.x, loc.y, size, size)) {
      image(cake, loc.x+size*.1, loc.y+size*.1, size*.8, size*.8);
    } 
    else {
      image(cake, loc.x, loc.y, size, size);
    }
  }
}

