class Tile {
  PVector loc;
  int size;
  int[] improvements = new int[2];
  int owner;
  int city;

  Tile(int loci, int locj, int city_, int owner_) {
    city = city_;
    owner = owner_;
    for (int i = 0;  i < improvements.length; i++) {
      improvements[i] = 0;
    }
    size = tileSize;
    loc = new PVector(loci*size, locj*size);
  }

  void display() {
    /* for (int i = 0; i < improvements.length; i++) {
     display the image
     } */
    colorMode(HSB, 360, 100, 100);
    if (owner == -1) {
      fill(100, 100, 100);
    } 
    else if (owner == 0) {
      fill(0, 100, 100, 50);
    } 
    else if (owner == 1) {
      fill(240, 100, 100);
    }
    rect(loc.x, loc.y, size, size);
  }
}

