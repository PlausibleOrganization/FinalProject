class PauseMenu {
  PauseMenu() {
  }
  //sets state to paused
  void set() {
    gameMode = new PVector(2, 0);
  }
  //shows rectangle that, if clicked, will resume game
  void resumeButton() {  
    rectMode(CORNER);
    textAlign(CENTER);
    textSize(20);
    colorMode(HSB, 360, 100, 100);
    //rectangle/text
    fillV(0, 100, 100);
    strokeWeight(5);
    stroke(120, 100, 100);
    rect(width/4, height/9, width/2, height/9);
    fillV(120, 100, 100);
    text("Resume", width/2, height*3/18);
    //if mouse clicked with rectangle, resume game
    gameMode = (button(width/4, height/9, width/2, height/9)) ? new PVector(1, turn) : gameMode;
  }
  void instButton() {
    rectMode(CORNER);
    textAlign(CENTER);
    textSize(20);
    colorMode(HSB, 360, 100, 100);
    //rectangle/text
    fillV(120, 100, 100);
    strokeWeight(5);
    stroke(240, 100, 100);
    rect(width/4, height/3, width/2, height/9);
    fillV(0, 100, 100);
    text("Instructions", width/2, height*7/18);
    //if mouse clicked with rectangle, open shop
    gameMode = (button(width/4, height/3, width/2, height/9)) ? new PVector(3, 0) : gameMode;
  }
}

class Settings {
  float briScale;
  Settings() {
    briScale = 1.0;
  }
  void display() {
    //return to menu button
    fillV(120, 100, 100);
    strokeWeight(5);
    stroke(240, 100, 100);
    rect(width/4, height*7/9, width/2, height/9);
    fillV(0, 100, 100);
    text("Back to menu", width/2, height*15/18);
    //if rectangle is clicked, return to menu
    if (button(width/4, height*7/9, width/2, height/9)) {
      p.set();
    }
  }
}

