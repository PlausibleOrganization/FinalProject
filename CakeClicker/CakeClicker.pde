PVector gameMode;
PImage soccerMom, farmer, van, cake, hole, assembly, city, cursor, dark, rocket, machine, witch, bakery;
int tilesX = 10;
int tilesY = 10;
int tileSize = 80;
Tile[][] tiles = new Tile[tilesX][tilesY];
//player id -1 is neutral, 0 and 1 are players
Player[] players = new Player[2];
boolean mouseReleased;
float turn;
PauseMenu p;
Settings s;
StartMenu st;

void setup() {
  size(1000, 800);
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

  //x==0 is for start menu, x==1 is for the game, x==2 for pause menu
  //y==0 is to indicate the turn during the game
  gameMode = new PVector(0, 0);
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(i);
  }
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j] = new Tile(i, j, -1);
    }
  }
  turn = 0;
  p = new PauseMenu();
  s = new Settings();
  st = new StartMenu();
}

void draw() {
  background(0);
  if (gameMode.x == 0) {
    st.display();
    st.update();
  }
  if (gameMode.x == 1) {
    gameMode.y = turn;
    //pause menu button
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
    for (int k = 0; k < players.length; k++) {
      if (gameMode.y % players.length == k) {
        players[k].display();
        players[k].update();
        for (int i = 0; i < tilesX; i++) {
          for (int j = 0; j < tilesY; j++) {
            tiles[i][j].display();
          }
        }
      }
    }
  }
  //pause screen
  if (gameMode.x == 2) {
    if (gameMode.y == 0) {
      p.resumeButton();
      p.settingsButton();
    } 
    else if (gameMode.y == 1) {
      s.display();
    }
  }
}

void keyPressed() {
  if (key == '+') {
    s.briScale+=.1;
  } 
  if (key == '_') {
    s.briScale-=.1;
  }
  if (key == 'p') {
    gameMode = new PVector(2, 0);
  }
}

void mouseReleased() {
  for (int i = 0; i < players.length; i++) {
    players[i].c.allowRun = true;
    players[i].allowEnd = true;
  }
}

