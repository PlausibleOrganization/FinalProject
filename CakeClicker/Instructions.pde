class Instruct {

  Instruct() {
  }

  void display() {
    //shows rules tab    
    colorMode(HSB, 360, 100, 100);
    textSize(20);
    fillV(120, 100, 100);
    strokeWeight(5);
    stroke(240, 100, 100);
    rect(width/4, height/2, width/2, height/9);
    fillV(240, 100, 100);
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
    text("Cake clicker was inspired by the amazing games of Civilization and Cookie Clicker. \n Try to take over the world with your armies. There are two players, P1 in the top left and \n P2 in the bottom right. The cakes in the upper-right corner are your currency, and buildings \n and upgrades will automatically increase how many are produced. All your initial \ncakes will come from clicking the cake. Attack the enemy player with your units and rule the world. \nBuildings can be created on tiles you own, which will be shaded your color. Use your \nunits to capture enemy land, buildings, and cities. Only one unit may be created per city per turn. \n Use the mouse to move and interact with the game. End your turn in the bottom left, and \nturns time out every minute. Press the pause button or press p to access the options menu.", width/2, height/9);
  }
}
