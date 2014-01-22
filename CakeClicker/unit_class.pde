class Unit {
  PVector tileLoc, loc;
  String name;
  int atk, def, hp, maxhp;
  int range, moved;
  int owner, id, level;
  PImage img;
  boolean selected, move, allowMove;
  int imgSize;

  Unit(int owner_, int id_, float x, float y) {
    deselector();
    selected = true;
    move = false;
    allowMove = true;
    imgSize = tileSize/2;
    owner = owner_;
    id = id_;
    level = 1;
    tileLoc = new PVector(x, y);
    loc = new PVector(x*tileSize, y*tileSize);
    moved = 0;
    if (id == 0) {
      name = "Soccer Mom";
      img = soccerMom;
      hp = 100;
      atk = 60;
      def = 30;
      range = 2;
    } 
    else if (id == 1) {
      name = "Soccer Mom Cavalry";
      img = van;
      hp = 100;
      atk = 40;
      def = 30;
      range = 4;
    }
    else if (id == 2) {
      name = "Farmer";
      img = farmer;
      hp = 150;
      atk = 30;
      def = 50;
      range = 1;
    }
    else if (id == 3) {
      name = "Rocket";
      img = rocket;
      hp = 1;
      atk = 500;
      def = 1;
      range = 20;
    }
    maxhp = hp;
  }
  void display() {
    imageMode(CORNER);
    imageV(img, loc.x, loc.y, imgSize, imgSize);
    if (selected) {
      unitMenu();
    }
  }
  void unitMenu() {
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
    fillV(100);
    rect(width-170, 370, 140, 36);
    textAlign(CENTER);
    textSize(25);
    fillV(0);
    text("MOVE", width-100, 395);
    if (moved == range) {
      allowMove = false;
      textSize(15);
      text("YOU HAVE USED THIS UNIT'S MOVES", width-170, 420);
    }
    if (button(width-170, 370, 140, 36) && allowMove) {
      move = !move;
      allowMove = false;
    }
    if (move) {
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          if (tileDist(tiles[int(tileLoc.x)][int(tileLoc.y)], tiles[i][j]) <= range - moved) {
            fillV(100);
            rect(tiles[i][j].loc.x, tiles[i][j].loc.y, tileSize, tileSize);
          }
        }
      }
      imageMode(CORNER);
      imageV(img, loc.x, loc.y, imgSize, imgSize);
      if (button2(0, 0, tileSize * tilesX, tileSize * tilesY)) {
        Tile tile1 = tiles[int(tileLoc.x)][int(tileLoc.y)];
        Tile tile2 = tiles[int(mouseTile().x)][int(mouseTile().y)];
        int tDist = tileDist(tile1, tile2);
        println(tDist + moved);
        println(tile2.loc+"     "+(tDist <= range - moved));
        if (mousePressed) {
          if (tDist + moved <= range) {
            moved += tDist;
            tile1.occupied = false;
            tile2.occupied = true;
            tileLoc = new PVector(tile2.tileLoc.x, tile2.tileLoc.y);
            loc = new PVector(tile2.loc.x, tile2.loc.y);
            move = false;
          }
        }
      }
    }
    println("Loc: "+loc);
  }
  void update() {
    if (button(loc.x, loc.y, imgSize, imgSize)) {
      deselector();
      selected = true;
    }
    if (selected) {
      if (button(width - 50, 250, 20, 20)) {
        selected = false;
      }
    }
  }
}

class UnitData {
  String name;
  int id, cost;
  PImage img;
  PVector menuLoc;

  UnitData(int id_) {
    id = id_;
    if (id == 0) {
      name = "Soccer Mom";
      img = soccerMom;
      cost = 50;
      menuLoc = new PVector(width-170, 340);
    } 
    else if (id == 1) {
      name = "Soccer Mom Cavalry";
      img = van;
      cost = 150;
      menuLoc = new PVector(width-120, 340);
    }
    else if (id == 2) {
      name = "Farmer";
      img = farmer;
      cost = 500;
      menuLoc = new PVector(width-170, 390);
    }
    else if (id == 3) {
      name = "Rocket";
      img = rocket;
      cost = 40000;
      menuLoc = new PVector(width-120, 390);
    }
  }
}

