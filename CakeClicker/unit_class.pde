class Unit {
  PVector tileLoc, loc, mouseTile;
  String name;
  int atk, def, hp, maxhp;
  int range, moved;
  int owner, unitId, level, index;
  PImage img;
  boolean selected, move, allowMove;
  int imgSize;

  Unit(float owner_, float unitId_, float x, float y) {
    deselector();
    selected = true;
    move = false;
    allowMove = true;
    imgSize = tileSize/2;
    owner = int(owner_);
    unitId = int(unitId_);
    level = 1;
    tileLoc = new PVector(x, y);
    loc = new PVector(x*tileSize, y*tileSize);
    moved = 0;
    index = -1;
    switch(unitId) {
    case 0:
      name = "Soccer Mom";
      img = soccerMom;
      hp = 100;
      atk = 75;
      def = 30;
      range = 3;
      break;
    case 1:
      name = "Soccer Mom Cavalry";
      img = van;
      hp = 100;
      atk = 60;
      def = 30;
      range = 6;
      break; 
    case 2:
      name = "Farmer";
      img = farmer;
      hp = 200;
      atk = 50;
      def = 50;
      range = 2;
      break; 
    case 3:
      name = "Rocket";
      img = rocket;
      hp = 1;
      atk = 300;
      def = 1;
      range = 10;
    }
    maxhp = hp;
  }
  void display() {
    displayImage();
    displayNumber();
    if (selected) {
      unitMenu();
    }
  }

  void displayImage() {
    imageMode(CORNER);
    colorMode(RGB, 255, 255, 255);
    imageV(img, loc.x, loc.y, imgSize, imgSize);
  }

  void displayNumber() {
    textAlign(CENTER);
    textSize(imgSize);
    switch (owner) {
    case 0:
      colorMode(RGB, 255, 255, 255);
      fillV(255, 0, 0);
      break;
    case 1:
      colorMode(RGB, 255, 255, 255);
      fillV(0, 0, 255);
      break;
    }
    text(owner+1, loc.x+20, loc.y+30);
  }

  void unitMenu() {
    mouseTile = new PVector(mouseX/tileSize, mouseY/tileSize);
    rectMode(CORNER);
    colorMode(RGB, 255, 255, 255);
    fillV(255);
    rect(width - 175, 250, 150, 225);
    fillV(200);
    rect(width - 50, 250, 20, 20);
    fillV(0);
    textSize(10);
    textAlign(CORNER);
    //should be formatted into one text function
    text("Owned by Player "+(owner+1)+"\nLocation: "+int(tileLoc.x)+" , "+int(tileLoc.y)+"\n"+name+"\nLevel "+level+"\nMovement: "+moved+"/"+range+"\nHealth: "+hp+"/"+maxhp+"\nATK: "+atk+" DEF:"+def, width-170, 265);
    if (owner == turnMod) {
      if (moved == range) {
        allowMove = false;
        textAlign(CORNER);
        textSize(15);
        text("YOU HAVE USED \nTHIS UNIT'S MOVES", width-170, 390);
      } 
      else {
        fillV(100);
        rect(width-170, 370, 140, 36);
        textAlign(CENTER);
        textSize(25);
        fillV(0);
        text("MOVE", width-100, 395);
      }
      move = (button(width-170, 370, 140, 36) && allowMove) ? !move : move;
      allowMove = (button(width-170, 370, 140, 36) && allowMove) ? false : allowMove;
      if (move) {
        move();
      }
    } 
    else {
      textSize(20);
      textAlign(CORNER);
      text("THIS IS NOT \nYOUR UNIT", width-170, 390);
    }
  }
  void move() {
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        if (tileDist(tiles[int(tileLoc.x)][int(tileLoc.y)], tiles[i][j]) <= range - moved) {
          if (owner == 0) { 
            colorMode(RGB, 255, 255, 255);
            fillV(255, 0, 0);
          } 
          else if (owner == 1) {
            colorMode(RGB, 255, 255, 255);
            fillV(0, 0, 255);
          }
          rect(tiles[i][j].loc.x, tiles[i][j].loc.y, tileSize, tileSize);
          imageMode(CENTER);
          imageV(tiles[i][j].img, tiles[i][j].loc.x + tileSize/2, tiles[i][j].loc.y + tileSize/2, tileSize*.85, tileSize*.85);
        }
      }
    }
    imageMode(CORNER);
    for (int i = 0; i < players.length; i++) {
      for (int j = players[i].units.size()-1; j > -1; j--) {
        Unit unit = players[i].units.get(j);
        unit.displayImage();
      }
    }
    imageV(img, loc.x, loc.y, imgSize, imgSize);
    textAlign(CENTER);
    textSize(25);
    fillV(0);
    text("Mouse over your target tile \nand press the M key to move!", tilesX*tileSize/2, tilesX*tileSize/2);
    if (button2(0, 0, tileSize * tilesX, tileSize * tilesY)) {
      Tile tile1 = tiles[int(tileLoc.x)][int(tileLoc.y)];
      Tile tile2 = tiles[int(mouseTile.x)][int(mouseTile.y)];
      int tDist = tileDist(tile1, tile2);
      if (tDist + moved <= range) {
        if (keyPressed && key == 'm') {
          move = false;
          if (!tile2.occupied) {
            moved += tDist;
            tile1.occupied = false;
            tile2.occupied = true;
            tileLoc = new PVector(tile2.tileLoc.x, tile2.tileLoc.y);
            loc = new PVector(tile2.loc.x, tile2.loc.y);
            tile1.unit = new PVector(-1, -1);
            tile2.unit = new PVector(owner, index);
          } 
          else {
            Unit u = players[int(tile2.unit.x)].units.get(int(tile2.unit.y));
            for (int i = 0; i < players.length; i++) {
              for (int j = players[i].units.size()-1; j > -1; j--) {
                players[i].units.get(j).update(j);
              }
            }
            if (owner != u.owner) {
              float power = atk - u.def;
              power *= random(.75, 1.25);
              power = (tile2.improvement == 1) ? power / 3: power;
              u.hp -= int(power);
              if (u.hp <= 0) {
                tile2.occupied = false;
                players[u.owner].units.remove(u.index);
                if (unitId == 3) {
                  tile1.occupied = false;
                  players[owner].units.remove(index);
                  refreshUnits();
                }
              }
            }
          }
        }
      }
    }
  }
  void update(int index_) {
    index = index_;
    if (button(loc.x, loc.y, imgSize, imgSize)) {
      deselector();
      selected = true;
    }
    selected = (selected && button(width - 50, 250, 20, 20)) ? false : selected;
  }
}

class UnitData {
  String name;
  int unitId, cost, imgSize;
  PImage img;
  PVector menuLoc;

  UnitData(int unitId_) {
    imgSize = 20;
    unitId = unitId_;
    switch (unitId) {
    case 0:
      name = "Soccer Mom";
      img = soccerMom;
      cost = 50;
      menuLoc = new PVector(width-170, 340);
      break;
    case 1:
      name = "Soccer Mom Cavalry";
      img = van;
      cost = 150;
      menuLoc = new PVector(width-170, 370);
      break;
    case 2:
      name = "Farmer";
      img = farmer;
      cost = 500;
      menuLoc = new PVector(width-170, 400);
      break;
    case 3:
      name = "Rocket";
      img = rocket;
      cost = 40000;
      menuLoc = new PVector(width-170, 430);
    }
  }

  void update() {
    switch (unitId) {
    case 0:
      cost = 50;
      break;
    case 1:
      cost = 150;
      break;
    case 2:
      cost = 500;
      break;
    case 3:
      cost = 40000;
    }
    cost = int(float(cost) * pow(costGrowth, players[turnMod].purchases[unitId]));
  }
}
