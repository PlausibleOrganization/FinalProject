class Tile {
  PVector loc;
  int size;
  int improvement;
  int owner;
  boolean selected, occupied, allowRun;
  String name;

  Tile(int loci, int locj, int owner_) {
    selected = false;
    occupied = false;
    owner = owner_;
    improvement = 0;
    size = tileSize;
    loc = new PVector(loci*size, locj*size);
  }

  void display() {
    colorMode(HSB, 360, 100, 100);
    strokeWeight(1);
    stroke(0, 0, 0);
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
      textAlign(CORNER);
      textSize(10);
      fill(0);
      text("Location: "+int(loc.x/tileSize)+" , "+int(loc.y/tileSize), width-160, 265);
      text(name, width-160, 280);
      fill(200);
      rect(width - 50, 250, 20, 20);
    }
  }
  
  void newUnits() {
    /*
    display unit creation buttons
    display costs
    if (cakes > cost && button(loc) && allowRun) {
      cakes -= cost;
    }
    */
  }
  void update() {
    if (improvement == 0) {
      name = "Grassland";
    } 
    else if (improvement == 1) {
      name = "City";
    }
    if (button(loc.x, loc.y, tileSize, tileSize)) {
      if (!(button(loc.x, loc.y, tileSize/2, tileSize/2) && occupied)) {
        deselector();
        selected = true;
      }
    }
    if (selected) {
      if (button(width - 50, 250, 20, 20)) {
        selected = false;
      }
    }
    for (int i = 0; i < players.length; i++) {
      for (int j = players[i].units.size(); j > 0; j--) {
        Unit unit = players[i].units.get(j);
        if (loc == unit.loc) {
          occupied = true;
        } 
        else {
          occupied = false;
        }
      }
    }
  }
}

