class Tile {
  PVector loc, tileLoc, nearestCity, unit;
  int size, improvement, owner, level, unitsBought, cityDist;
  boolean selected, occupied, allowBuy;
  String name;
  PImage img;

  Tile(int loci, int locj) {
    selected = false;
    occupied = false;
    allowBuy = false;
    owner = -1;
    improvement = 0;
    size = tileSize;
    tileLoc = new PVector(loci, locj);
    loc = new PVector(loci*size, locj*size);
    cityDist = tilesX + tilesY;
    unit = new PVector(-1, -1);
  }

  void display() {
    imageMode(CORNER);
    colorMode(HSB, 360, 100, 100);
    if (owner == -1) {
      tint(0, 0, 100*s.briScale, 100);
    } 
    else if (owner == 0) {
      tint(0, 50, 100*s.briScale, 50);
    } 
    else if (owner == 1) {
      tint(240, 50, 100*s.briScale, 50);
    }
    image(img, loc.x, loc.y, tileSize, tileSize);
    rectMode(CORNER);
    //rect(loc.x, loc.y, size, size);
    if (selected) {
      tileMenu();
    }
  }
  void setCity() {
    if (cityDist <= 6) {
      improvement = 1;
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          if (tileDist(tiles[int(tileLoc.x)][int(tileLoc.y)], tiles[i][j]) <= 1) { 
            tiles[i][j].owner = owner;
          }
        }
      }
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
      if (improvement == 1) {
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
              unit.x = owner;
              unit.y = players[turnMod].units.size()-1;
            }
          }
        }

        else {
          textSize(25);
          text("You have \nalready \npurchased \na unit.", width-170, 335);
        }
      }
    }
  }

  void update() {
    if (improvement == 0) {
      img = grasslands;
      name = "Grassland";
      level = 0;
    } 
    else {
      if (level == 0) {
        level = 1;
      }
      if (improvement == 1) {
        img = city;
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
    if (occupied && owner != -1 && owner != unit.x && improvement == 1) {
      owner = int(unit.x);
    }
    int cityDist_ = tilesX + tilesY;
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        if ((new PVector(i, j)) != tileLoc) {
          if (tiles[i][j].improvement == 1) {
            if (tileDist(tiles[i][j], tiles[int(tileLoc.x)][int(tileLoc.y)]) < cityDist_) {
              cityDist_ = tileDist(tiles[i][j], tiles[int(tileLoc.x)][int(tileLoc.y)]);
            }
          }
        }
      }
    }
    cityDist = cityDist_;
    println(tiles[1][1].cityDist);
  }
}

