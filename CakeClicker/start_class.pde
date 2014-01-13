class StartMenu {
  StartMenu() {
  }
  //set state to start menu
  void set() {
    gameMode = new PVector(0, 0);
  }
  void display() {
    //draws reset button
    colorMode(HSB, 360, 100, 100);
    textSize(20);
    fill(120, 100, 100);
    strokeWeight(5);
    stroke(240, 100, 100);
    rect(width/4, height/3, width/2, height/9);
    fill(240, 100, 100);
    textAlign(CENTER);
    text("START GAME", width/2, height*7/18);
  }
  void update() {
    //if clicked, then start game
    if (button(width/4, height/3, width/2, height/9)) {
      gameMode = new PVector(1, 0);
    }
  }
}
