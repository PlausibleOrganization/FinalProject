class Unit {
  PVector loc;
  String name;
  float atk, def, hp;
  int range, id;
  PImage img;

  Unit(int id_, float x, float y) {
    id = id_;
    loc = new PVector(x, y);
    if (id == 0) {
      name = "Soccer Mom";
      hp = 100;
      atk = 60;
      def = 30;
      range = 2;
    } 
    else if (id == 1) {
      name = "Soccer Mom Cavalry";
      hp = 100;
      atk = 40;
      def = 30;
      range = 4;
    }
    else if (id == 2) {
      name = "Farmer";
      hp = 150;
      atk = 30;
      def = 50;
      range = 1;
    }
    else if (id == 3) {
      name = "Rocket";
      hp = 1;
      atk = 500;
      def = 1;
      range = 20;
    }
  }
  void display() {
    imageV(img, tileSize*loc.x, tileSize*loc.y);
  }

  void update() {
  }
}

