class Tile {
<<<<<<< HEAD
  PVector loc;
  int size;
  int improvement;
  int owner;
  boolean selected, occupied, allowRun;
=======
  PVector loc, tileLoc;
  int size, improvement, owner, level, unitsBought;
  boolean selected, occupied, allowBuy;
>>>>>>> origin/Brian
  String name;

  Tile(int loci, int locj, int owner_) {
    selected = false;
    occupied = false;
    allowBuy = false;
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
<<<<<<< HEAD
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
=======
      tileMenu();
    }
  }

  void tileMenu() {
    colorMode(HSB, 255, 255, 255);
    fillV(255);
    rect(width - 175, 250, 150, 225);
    fillV(200);
    rect(width - 50, 250, 20, 20);
    fillV(0);
    textSize(10);
    textAlign(CORNER);
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
    if (owner == turnMod) {
      if (unitsBought < 1) {
        textSize(15);
        text("Purchase a unit:", width-170, 330);
        imageMode(CORNER);
        rect(width-170, 340, 30, 30);
        imageV(soccerMom, width-170, 340, 30, 30);
        textSize(10);
        text(50, width-160, 385);
        if (button(width-170, 340, 30, 30) && players[turnMod].cakes >= 50 && !occupied) {          
          players[turnMod].cakes-=50;
          players[turnMod].units.add(new Unit(0, tileLoc.x, tileLoc.y));
        }
      } 
      else {
        textSize(25);
        text("You have already purchased a unit.", width-170, 325);
      }
    }
>>>>>>> origin/Brian
  }
  void update() {
    if (improvement == 0) {
      name = "Grassland";
<<<<<<< HEAD
    } 
    else if (improvement == 1) {
      name = "City";
    }
    if (button(loc.x, loc.y, tileSize, tileSize)) {
      if (!(button(loc.x, loc.y, tileSize/2, tileSize/2) && occupied)) {
        deselector();
        selected = true;
=======
      level = 0;
    } 
    else {
      if (level == 0) {
        level = 1;
      }
      if (improvement == 1) {
        name = "City";
>>>>>>> origin/Brian
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
<<<<<<< HEAD
      for (int j = players[i].units.size(); j > 0; j--) {
=======
      for (int j = players[i].units.size() - 1; j > 0; j--) {
>>>>>>> origin/Brian
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

