class Player {
  float cakes;
  float cps;
  Clicker c;
  int id;

  Player(int id_) {
    id = id_;
    cakes = 0;
    c = new Clicker();
  }

  void update() {
    c.update();
    if (c.clicked) {
      cakes++;
      // mouseReleased = false;
    }
  }

  void display() {
    c.display();
    if (id == 0) {
      fill(0, 100, 100);
    }
    else if (id == 1) {
      fill(240, 100, 100);
    }
    textSize(25);
    textAlign(CENTER);
    text("Player "+(id + 1)+"'s Turn", width-100, 50);
    textSize(20);
    colorMode(RGB, 255, 255, 255);
    fill(200);
    textAlign(CENTER);
    text("Cakes: "+int(cakes), width-100, 100);
    textSize(10);
    text("Cakes per second: "+int(cps), width-100, 200);
  }
}

