class Tile {
  PVector loc, tileLoc;
  int size, improvement, owner, level;
  boolean selected, occupied;
  String name;

  Tile(int loci, int locj, int owner_) {
    selected = false;
    occupied = false;
    owner = owner_;
    improvement = 0;
    size = tileSize;
    tileLoc = new PVector(loci, locj);
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
      textSize(10);
      textAlign(CORNER);
      colorMode(HSB, 255, 255, 255);
      fill(255);
      rect(width - 175, 250, 150, 225);
      fill(0);
      if (owner > -1) {
        text("Owned by Player "+(owner+1), width-170, 265);
      } 
      else {
        text("Unclaimed territory", width-170, 265);
      }
      text("Location: "+int(tileLoc.x)+" , "+int(tileLoc.y), width-170, 280);
      text(name, width-170, 295);
      if (level > 0) {
        text("Level "+level, width-170, 310);
      } 
      else {
        text("Undeveloped tile", width-170, 310);
      }

      fill(200);
      rect(width - 50, 250, 20, 20);
    }
  }

  void update() {
    if (improvement == 0) {
      name = "Grassland";
      level = 0;
    } 
    else {
      if (level == 0) {
        level = 1;
      }
      if (improvement == 1) {
        name = "City";
      }
    }
    if (button(loc.x, loc.y, tileSize, tileSize) &&!(button(loc.x, loc.y, tileSize/2, tileSize/2) && occupied)) {
      deselector();
      selected = true;
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

