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
    improvement = cityDist >= minCityDist ? 1 : 0;
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
    switch (owner) {
    case -1:
      text("Owned by Player "+(owner+1), width-170, 265);
      break;
    default:
      text("Unclaimed territory", width-170, 265);
      break;
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
      if (improvement == 0) {
        textSize(15);
        text("Purchase a unit:", width-170, 330);
        imageMode(CORNER);
        for (int i = 0; i <unitData.length; i++) {
          rect(tileData[i].menuLoc.x, tileData[i].menuLoc.y, tileData[i].imgSize, tileData[i].imgSize);
          imageV(tileData[i].img, tileData[i].menuLoc.x, tileData[i].menuLoc.y, tileData[i].imgSize, tileData[i].imgSize);
          if (i == 0 && cityDist < minCityDist) {
            textSize(8);
            text("YOU MAY NOT SETTLE HERE", tileData[i].menuLoc.x + tileData[i].imgSize + 10, tileData[i].menuLoc.y + tileData[i].imgSize/2);
          } 
          else {
            textSize(8);
            text(tileData[i].cost+"\nCPS: "+tileData[i].cps, tileData[i].menuLoc.x + tileData[i].imgSize + 10, tileData[i].menuLoc.y + tileData[i].imgSize/2 - 5);
            if (button(tileData[i].menuLoc.x, tileData[i].menuLoc.y, tileData[i].imgSize, tileData[i].imgSize) && players[turnMod].cakes >= tileData[i].cost) {
              if ((tileData[i].improvement == 1 && cityDist >= minCityDist) || tileData[i].improvement != 1) {
                players[turnMod].cakes-=tileData[i].cost;
                improvement = tileData[i].improvement;
                img = tileData[i].img;
              }
            }
          }
        }
      }
      else if (improvement == 1) {
        if (unitsBought < 1) {
          if (occupied) {
            textSize(25);
            text("This tile \nis \noccupied.", width-170, 335);
          } 
          else {
            textSize(15);
            text("Purchase a unit:", width-170, 330);
            imageMode(CORNER);
            for (int i = 0; i <unitData.length; i++) {
              unitData[i].update();
              textSize(10);
              rect(unitData[i].menuLoc.x, unitData[i].menuLoc.y, unitData[i].imgSize, unitData[i].imgSize);
              imageV(unitData[i].img, unitData[i].menuLoc.x, unitData[i].menuLoc.y, unitData[i].imgSize, unitData[i].imgSize);
              textSize(10);
              text(unitData[i].cost, unitData[i].menuLoc.x + unitData[i].imgSize + 10, unitData[i].menuLoc.y + unitData[i].imgSize/2);
              if (button(unitData[i].menuLoc.x, unitData[i].menuLoc.y, unitData[i].imgSize, unitData[i].imgSize) && players[turnMod].cakes >= unitData[i].cost && !occupied) {
                players[turnMod].purchases[i]++;
                players[turnMod].cakes-=unitData[i].cost;
                players[turnMod].units.add(new Unit(turnMod, i, int(tileLoc.x), int(tileLoc.y)));
                unitsBought++;
                occupied = true;
                unit.x = owner;
                unit.y = players[turnMod].units.size()-1;
              }
            }
          }
        }
      }
      else if (improvement == 1) {
        textSize(25);
        text("You have \nalready \npurchased \na unit.", width-170, 335);
      }
    }
  }
  void update() {
    switch (improvement) {
    case 0:
      img = grasslands;
      name = "Grassland";
      level = 0;
      break;
    case 1:
      img = city;
      name = "City";
      level = (level == 0) ? 1 : level;
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          tiles[i][j].owner = tileDist(tiles[int(tileLoc.x)][int(tileLoc.y)], tiles[i][j]) <= 1 ? owner : tiles[i][j].owner;
        }
      }
      break;
    case 2:
      name = "Bakery";
      level = (level == 0) ? 1 : level;
    case 3:
      name = "Space Machine";
      level = (level == 0) ? 1 : level;
    case 4:
      name = "WITCHCRAFT MAGIC";
      level = (level == 0) ? 1 : level;
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
    owner = (occupied && owner != -1 && owner != unit.x && improvement == 1) ? int(unit.x) : owner;
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
  }
}

class TileData {
  int cps;
  String name;
  int improvement, cost, imgSize;
  PImage img;
  PVector menuLoc;

  TileData(int improvement_) {
    imgSize = 20;
    improvement = improvement_;
    switch (improvement) {
    case 1:
      cps = 1;
      img = city;
      cost = 500;
      menuLoc = new PVector(width-170, 340);
      break;
    case 2:
      cps = 10;
      img = bakery;
      cost = 250;
      menuLoc = new PVector(width-170, 370);
      break;
    case 3:
      cps = 100;
      img = machine;
      cost = 4000;
      menuLoc = new PVector(width-170, 400);
      break;
    case 4:
      cps = 1000;
      img = witch;
      cost = 100000;
      menuLoc = new PVector(width-170, 430);
    }
  }
}

