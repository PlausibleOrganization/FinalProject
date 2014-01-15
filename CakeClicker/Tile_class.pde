class Tile {
  PVector loc;
  int size;
  int improvement;
  int owner;
  boolean selected;

  Tile(int loci, int locj, int owner_) {
    selected = false;
    owner = owner_;
    improvement = 0;
    size = tileSize;
    loc = new PVector(loci*size, locj*size);
  }

  void display() {
    colorMode(HSB, 360, 100, 100);
    strokeWeight(1);
    stroke(0, 0, 0);
    /* for (int i = 0; i < improvements.length; i++) {
     display the image
     } */
    if (owner == -1) {
      fillV(100, 100, 100);
    } 
    else if (owner == 0) {
      fillV(0, 100, 100, 50);
    } 
    else if (owner == 1) {
      fillV(240, 100, 100, 50);
    }
    rectMode(CORNER);
    rect(loc.x, loc.y, size, size);
    if (selected) {
      colorMode(HSB, 255, 255, 255);
      fill(255);
      rect(width - 175, 250, 150, 225);
      fill(200);
      rect(width - 50, 250, 20, 20);
    }
  }

  void update() {
    if (button(loc.x, loc.y, tileSize, tileSize)) {
      if (!button(loc.x, loc.y, tileSize/2, tileSize/2)) {
        selected = true;
      }
    }
    if (selected) {
      if (button(width - 50, 250, 20, 20)) {
        selected = false;
      }
    }
  }
}

