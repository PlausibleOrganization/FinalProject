PVector gameMode;
PImage soccerMom, farmer, van, cake, hole, assembly, city, cursor, dark, rocket, machine, witch, bakery;
int tilesX = 10;
int tilesY = 10;
int tileSize = 80;
Tile[][] tiles = new Tile[tilesX][tilesY];
//player id -1 is neutral, 0 and 1 are players
Player[] players = new Player[2];
boolean mouseReleased;
int turn;
int turnMod;
PauseMenu p;
Settings s;
StartMenu st;

Unit test;

void setup() {
  size(1000, 800);
  constructImages();
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

  test = new Unit(0, 0, 0);
}

void draw() {
  turnMod = int(gameMode.y % players.length);
  background(0);
  if (gameMode.x == 0) {
    st.display();
    st.update();
  }
  if (gameMode.x == 1) {
    gameMode.y = turn;
    pauseAndQuit();
    players[turnMod].display();
    players[turnMod].update();
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        tiles[i][j].update();
        tiles[i][j].display();
      }
    }
  }
  test.update();
  test.display();
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
