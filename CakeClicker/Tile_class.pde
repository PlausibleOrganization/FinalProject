class Tile {
  PVector loc, tileLoc;
  int size, improvement, owner, level, unitsBought;
  boolean selected, occupied, allowBuy;
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
    if (improvement == 0) {
      imageV(grasslands, loc.x, loc.y, tileSize, tileSize);
    } 
    else if (improvement == 1) { 
      imageV(city, loc.x, loc.y, tileSize, tileSize);
    }
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
    //rect(loc.x, loc.y, size, size);
    if (selected) {
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
        for (int i = 0; i <unitData.length; i++) {
          rect(unitData[i].menuLoc.x, unitData[i].menuLoc.y, 30, 30);
          imageV(unitData[i].img, unitData[i].menuLoc.x, unitData[i].menuLoc.y, 30, 30);
          textSize(10);
          text(unitData[i].cost, unitData[i].menuLoc.x + 10, unitData[i].menuLoc.y + 45);
          if (button(unitData[i].menuLoc.x, unitData[i].menuLoc.y, 30, 30) && players[turnMod].cakes >= unitData[i].cost && !occupied) {          
            players[turnMod].cakes-=unitData[i].cost;
            players[turnMod].units.add(new Unit(turnMod, i, int(tileLoc.x), int(tileLoc.y)));
            unitsBought++;
            occupied = true;
          }
        }
      } 
      else {
        textSize(25);
        text("You have \nalready \npurchased \na unit.", width-170, 335);
      }
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
    //    for (int i = 0; i < players.length; i++) {
    //      for (int j = players[i].units.size() - 1; j > -1; j--) {
    //        Unit unit = players[i].units.get(j);
    //        if (loc == unit.loc) {
    //          occupied = true;
    //        } 
    //        else {
    //          occupied = false;
    //        }
    //      }
  }
}
