class StartMenu {
  ArrayList<cake>cakes = new ArrayList<cake>(5);
  StartMenu() {
  }
  //set state to start menu
  void set() {
    gameMode = new PVector(0, 0);
  }
  void display() {
    //draws cakes
    if (cakes.size() < 10) {
      cakes.add(new cake(random(width), 0));
    }
    for (int i = cakes.size() - 1; i > 0; i--) {
      cake c = cakes.get(i);
      c.display();
      c.update();
    }
    //draws reset button
    colorMode(HSB, 360, 100, 100);
    textSize(20);
    fillV(120, 100, 100, 70);
    strokeWeight(5);
    stroke(240, 100, 100, 70);
    rect(width/4, height/3, width/2, height/9);
    fillV(240, 100, 100, 70);
    textAlign(CENTER);
    text("START GAME", width/2, height*7/18 + 7);
    textSize(100);
    fillV(55, 93, 98, 70);
    text("CAKE CLICKER", width/2, height/4);
  }
  void update() {
    //if clicked, then start game
    if (button(width/4, height/3, width/2, height/9)) {
      gameMode = new PVector(1, 0);
    }
  }
}

