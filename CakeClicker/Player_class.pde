class Player {
  float cakes;
  float cps;
  Clicker c;
  int id;
  boolean allowEnd;
  ArrayList<Unit> units = new ArrayList<Unit>();

  Player(int id_) {
    id = id_;
    cakes = 0;
    c = new Clicker();
    allowEnd = true;
  }

  void update() {
    c.update();
    if (c.clicked) {
      cakes++;
      // mouseReleased = false;
    }
    for (int i = units.size() - 1; i > -1; i--) {
      Unit unit = units.get(i);
      unit.update();
    }
  }

  void display() {
    c.display();
    if (id == 0) {
      fillV(0, 100, 100);
    }
    else if (id == 1) {
      fillV(240, 100, 100);
    }
    //player n's turn
    textSize(25);
    textAlign(CENTER);
    text("Player "+(id + 1)+"'s Turn", width-100, 50);
    //cake info
    textSize(20);
    colorMode(RGB, 255, 255, 255);
    fillV(200);
    textAlign(CENTER);
    text("Cakes: "+int(cakes), width-100, 100);
    textSize(10);
    text("Cakes per second: "+int(cps), width-100, 200);
    //end turn button
    rectMode(CORNER);
    fillV(255);
    rect(width-175, height-300, 150, 75);
    fillV(0);
    textSize(25);
    text("End turn", width-100, height-255);
    if (button(width-175, height-300, 150, 75) && allowEnd) {
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          tiles[i][j].unitsBought = 0;
        }
      }
      for (int i = 0; i < players.length; i++) {
        players[i].allowEnd = false;
      }
      turn++;
    }
    for (int i = units.size() - 1; i > -1; i--) {
      Unit unit = units.get(i);
      unit.display();
    }
  }
}

