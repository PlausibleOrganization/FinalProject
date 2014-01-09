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
    c.display();
    println(cakes);
  }
}

