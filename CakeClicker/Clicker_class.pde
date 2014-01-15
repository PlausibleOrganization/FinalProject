class Clicker {
  PVector loc;
  int size;
  boolean clicked;
  boolean allowRun;

  Clicker() {
    //set loc to right side of screen
    loc = new PVector(width-200, 50);
    //set size to 200
    size = 200;
    //control cakes, one cake per click + release pair
    clicked = false;
    allowRun = true;
  }

  void update() {
    //if the cake is pressed and allowed to run, run it
    if (button(loc.x, loc.y, size, size) && allowRun) {
      clicked = true;
      allowRun = false;
    } 
    else {
      clicked = false;
    }
  }

  void display() {
    //display cake
    imageMode(CORNER);
    if (button(loc.x, loc.y, size, size)) {
      imageV(cake, loc.x+size*.1, loc.y+size*.1, size*.8, size*.8);
    } 
    //if clicked, shrink cake
    else {
      imageV(cake, loc.x, loc.y, size, size);
    }
  }
}

