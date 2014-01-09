class Player {
  float cakes;
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
    }
  }

  void display() {
    textSize(25);
    if (id == 0) {
      fill(0, 100, 100);
    }
    else if (id == 1) {
      fill(240, 100, 100);
    }
    textAlign(CENTER);
    text("Player "+(id + 1)+"'s Turn", width-100, 50);
    c.display();
    println(cakes);
  }
}

