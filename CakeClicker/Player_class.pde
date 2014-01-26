class Player {
  float cakes;
  float cps;
  Clicker c;
  int id, citiesPurchased;
  boolean allowEnd, ownCities;
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
    citiesPurchased = 0;
    ownCities = true;
  }

  void update() {
    //update clicker
    c.update();
    //if clicked, add 1 cake
    cakes = c.clicked ? cakes + 1 : cakes;
    //set c.clicked to false so it is one cake/click
    c.clicked = false;
    //once a second, run
    if (ti.cakeGain()) {
      //find total cps, see if they have any cities
      cps = 0;
      ownCities = false;
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          if (tiles[i][j].owner == id) {
            cps = (tiles[i][j].improvement == 0) ? cps : cps + tileData[tiles[i][j].improvement-1].cps;
            ownCities = (tiles[i][j].improvement == 1) ? true : ownCities;
          }
        }
      }
      //add cps to cakes
      cakes += cps;
      //if no cities are owner, game over
      gameMode = ownCities ? gameMode : new PVector(4, turnMod);
    }
  }

  void updateUnits() {
    //update all units owner by player
    for (int i = units.size() - 1; i > -1; i--) {
      Unit unit = units.get(i);
      unit.update(i);
    }
  }

  void display() {
    //display clicker
    c.display();
    //fill player n's turn
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
    //set unitsBought to 0 for all tiles
    if (button(width-175, height-300, 150, 75) && allowEnd) {
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          tiles[i][j].unitsBought = 0;
        }
      }
      //don't allow turn to end if mousePressed
      for (int i = 0; i < players.length; i++) {
        players[i].allowEnd = false;
      }
      //calculate new turn and turnMod
      turn++;
      turnMod = turn % players.length;
    }
  }

  void displayUnits() {
    //display all units ownerd by player
    for (int i = units.size() - 1; i > -1; i--) {
      Unit unit = units.get(i);
      unit.display();
    }
  }
}

