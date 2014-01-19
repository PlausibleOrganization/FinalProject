class Unit {
  PVector tileLoc, loc;
  String name;
  float atk, def, hp;
  int owner, id, range, moved;
  PImage img;
  boolean selected;
  int imgSize;

  Unit(int owner_, int id_, float x, float y) {
    selected = false;
    imgSize = tileSize/2;
    owner = owner_;
    id = id_;
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
  }
  void display() {
    imageMode(CORNER);
    imageV(img, loc.x, loc.y, imgSize, imgSize);
    if (selected) {
      colorMode(HSB, 255, 255, 255);
      fillV(255);
      rect(width - 175, 250, 150, 225);
      fillV(200);
      rect(width - 50, 250, 20, 20);
    }
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

