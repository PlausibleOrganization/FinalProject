void pauseAndQuit() {
  //pause menu button
  colorMode(HSB, 255, 255, 255);
  fillV(255);
  rect(width-175, height-200, 150, 50);
  fillV(0);
  textSize(25);
  text("Pause", width-100, height-167);
  if (button(width-175, height-200, 150, 50)) {
    gameMode = new PVector(2, 0);
  }
  //quit gamemode button
  fillV(255);
  rect(width-175, height-125, 150, 100);
  fillV(0);
  textSize(25);
  text("Quit to\n main menu", width-102.5, height-85);
  if (button(width-175, height-125, 150, 100)) {
    gameMode = new PVector(0, 0);
  }
}

void constructImages() {
  cake = loadImage("Cake.png");
  hole = loadImage("Black_Hole.png");
  assembly = loadImage("Assembly.png");
  city = loadImage("City.png");
  cursor = loadImage("Cursor.png");
  dark = loadImage("Dark.png");
  rocket = loadImage("Rocket.png");
  machine = loadImage("Space_Machine.png");
  witch = loadImage("Witchcraft.png");
  bakery = loadImage("Bakery.png");
  farmer = loadImage("cartoon-people-farmer.png");
  soccerMom = loadImage("soccer_mom.png");
  van = loadImage("blue-van-hi.png");
}

