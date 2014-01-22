class Unit {
  PVector tileLoc, loc;
  String name;
  int atk, def, hp, maxhp;
  int range, moved;
  int owner, id, level;
  PImage img;
  boolean selected;
  int imgSize;

  Unit(int owner_, int id_, float x, float y) {
    deselector();
    selected = true;
    imgSize = tileSize/2;
    owner = owner_;
    id = id_;
    level = 1;
    tileLoc = new PVector(x, y);
    loc = new PVector(x*tileSize, y*tileSize);
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
    colorMode(HSB, 255, 255, 255);
    fillV(255);
    rect(width - 175, 250, 150, 225);
    fillV(200);
    rect(width - 50, 250, 20, 20);
    fillV(0);
    textSize(10);
    textAlign(CORNER);
    //should be formatted into one text function
    text("Owned by Player "+(owner+1), width-170, 265);
    text("Location: "+int(tileLoc.x)+" , "+int(tileLoc.y), width-170, 280);
    text(name, width-170, 295);
    text("Level "+level, width-170, 310);
    text("Movement: "+moved+"/"+range, width-170, 325);
    text("Health: "+hp+"/"+maxhp, width-170, 340);
    text("ATK: "+atk, width-170, 355);
    text("DEF: "+def, width-130, 355);
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

  void selectMenu() {
    rectMode(CENTER);
    rect(width/2, height/2, 100, 500);
    rectMode(CORNER);
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

