class Instruct {

  Instruct() {
  }

  void display() {
    //shows rules tab    
    colorMode(HSB, 360, 100, 100);
    textSize(20);
    fillV(120, 100, 100, 70);
    strokeWeight(5);
    stroke(240, 100, 100, 70);
    rect(width/4, height/2, width/2, height/9);
    fillV(240, 100, 100, 70);
    textAlign(CENTER);
    text("RULES & INSTRUCTIONS", width/2, height*4/7 - 6);
  }

  void update() {
    //changes to rules tab    
    if (button(width/4, height/2, width/2, height/9)) {
      gameMode = new PVector(3, 0);
    }
  }

  void instructions() {
    fillV(120, 100, 100);
    rect(width/4, height*4/5, width/2, height/9);
    fillV(240, 100, 100);
    text("RETURN TO START", width/2, height*6/7 + 7);
    fillV(0, 100, 100);
    if (button(width/4, height*4/5, width/2, height/9)) {
      gameMode = new PVector(0, 0);
    }
    text("Cake clicker was inspired by the amazing games of Civilization and Cookie Clicker. \n In the campaign mode, you are trying to take over the world with your armies. \n The cakes in the upper-right corner are your currency, and buildings will automatically \nincrease how many you recieve a second. Attack the enemy player and rule the world. \n In the free play mode, try to get as many cookies as possible.", width/2, height/9);
  }
}

