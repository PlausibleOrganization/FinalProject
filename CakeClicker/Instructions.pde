class Instruct {

  Instruct() {
  }

  void display() {
    //shows instructions/rules tab    
    colorMode(HSB, 360, 100, 100);
    textSize(20);
    fillV(120, 100, 100, 70);
    strokeWeight(5);
    stroke(240, 100, 100*s.briScale, 70);
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
    //displayers button
    fillV(120, 100, 100);
    rect(width/4, height*4/5, width/2, height/9);
    fillV(240, 100, 100);
    switch (turn) {
    case -1:
      text("RETURN TO START", width/2, height*6/7 + 7);
      break; 
      //if the game has started, return to game
    default :
      text("RETURN TO GAME", width/2, height*6/7 + 7);
      break;
    }
    if (button(width/4, height*4/5, width/2, height/9)) {
      //if the game hasn't started, return to start menu
      switch (turn) {
      case -1:
        gameMode = new PVector(0, 0);
        break; 
        //if the game has started, return to game
      default :
        gameMode = new PVector(1, turn);
        break;
      }
    }
    fillV(0, 100, 100);
    //display instructions
    text("Cake clicker was inspired by the amazing games of Civilization and Cookie Clicker. \n Try to take over the world with your armies. There are two players, P1 in the top left and \n P2 in the bottom right. The cakes in the upper-right corner are your currency, and buildings \n and upgrades will automatically increase how many are produced. All your initial \ncakes will come from clicking the cake. Attack the enemy player with your units and rule the world. \nBuildings can be created on tiles you own, which will be shaded your color. Use your \nunits to capture enemy land, buildings, and cities. Only one unit may be created per city per turn. \n Use the mouse to move and interact with the game. End your turn in the bottom left, and \nturns time out every minute. Press the pause button or press p to access the options menu. \n\nRules of units and tiles:\nOne unit per tile. Move to an enemy to attack \nCities spawn units and expand your territory \nUndeveloped tiles you control can be improved to produce cakes", width/2, height/9);
  }
}

