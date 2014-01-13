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
    fill(0, 100, 100);
    strokeWeight(5);
    stroke(120, 100, 100);
    rect(width/4, height/9, width/2, height/9);
    fill(120, 100, 100);
    text("Resume", width/2, height*3/18);
    //if mouse clicked with rectangle, resume game
    if (button(width/4, height/9, width/2, height/9)) {
      gameMode = new PVector(1, turn);
    }
  }
  void settingsButton() {
    rectMode(CORNER);
    textAlign(CENTER);
    textSize(20);
    colorMode(HSB, 360, 100, 100);
    //rectangle/text
    fill(120, 100, 100);
    strokeWeight(5);
    stroke(240, 100, 100);
    rect(width/4, height/3, width/2, height/9);
    fill(0, 100, 100);
    text("Settings", width/2, height*7/18);
    //if mouse clicked with rectangle, open shop
    if (button(width/4, height/3, width/2, height/9)) {
      gameMode = new PVector(2, 1);
    }
  }
}

class Settings {
  float briScale;
  Settings() {
    briScale = 1.0;
  }
  void display() {
    //return to menu button
    fill(120, 100, 100);
    strokeWeight(5);
    stroke(240, 100, 100);
    rect(width/4, height*7/9, width/2, height/9);
    fill(0, 100, 100);
    text("Back to menu", width/2, height*15/18);
    //if rectangle is clicked, return to menu
    if (button(width/4, height*7/9, width/2, height/9)) {
      p.set();
    }
  }

  /*void bright() {
    //increases brightness
    fillV(255);
    rect(width/4 - 75, 100, 200, 75);
    fillV(0);
    textSize(25);
    text("Pause", width-100, height-167);
    if (button(width/4 - 75, 100, 200, 75)) {
      briScale+=.1;
    }
  }*/
}

