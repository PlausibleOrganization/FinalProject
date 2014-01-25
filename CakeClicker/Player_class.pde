class Player {
  float cakes;
  float cps;
  Clicker c;
  int id;
  boolean allowEnd;
  ArrayList<Unit> units = new ArrayList<Unit>();
  int[] purchases = new int[4];

  Player(int id_) {
    id = id_;
    cakes = 0;
    c = new Clicker();
    allowEnd = true;
    for (int i = 0; i < purchases.length; i++) {
      purchases[i] = 0;
    }
  }

  void update() {
    c.update();
    if (ti.cakeGain()) {
      cps = 0;
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          if (tiles[i][j].owner == id) {
            if (tiles[i][j].improvement == 1) {
              cps++;
            }
          }
        }
      }
      cakes += cps;
    }
    cakes = c.clicked ? cakes + 1 : cakes;
    if (ti.cakeGain()) {
    }
  }

  void updateUnits() {
    for (int i = units.size() - 1; i > -1; i--) {
      Unit unit = units.get(i);
      unit.update(i);
    }
  }

  void display() {
    c.display();
    switch(id) {
    case 0:
      fillV(0, 100, 100);
      break; 
    case 1:
      fillV(240, 100, 100);
      break;
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
    //turn time left
    textSize(25);
    text(ti.viewTime(), width-100, 240);
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
      turnMod = turn % players.length;
    }
  }

  void displayUnits() {
    for (int i = units.size() - 1; i > -1; i--) {
      Unit unit = units.get(i);
      unit.display();
    }
  }
}

