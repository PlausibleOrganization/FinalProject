PVector gameMode;
PImage soccerMom, farmer, van, cake, hole, assembly, city, grasslands, cursor, dark, rocket, machine, witch, bakery;
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

void setup() {
  size(1000, 800);
  //construct all PImages
  constructImages();
  //x==0 is for start menu, x==1 is for the game, x==2 for pause menu
  //y==0 is to indicate the turn during the game
  gameMode = new PVector(0, 0);
  //construct players
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(i);
  }
  //construct tiles
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j] = new Tile(i, j, -1);
    }
  }
  tiles[0][0].owner = 0;
  tiles[0][0].improvement = 1;
  tiles[tilesX-1][tilesY-1].owner = 1;
  tiles[tilesX-1][tilesY-1].improvement = 1;
  //set turn to Player 1;
  turn = 0;
  //construct menus
  p = new PauseMenu();
  s = new Settings();
  st = new StartMenu();
}

void draw() {
  //turnMod is what player's turn it is
  turnMod = int(gameMode.y % players.length);
  background(0);
  //starting screen
  if (gameMode.x == 0) {
    st.display();
    st.update();
  }
  //game screens
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
  //pause screen
  if (gameMode.x == 2) {
    //main pause menu
    if (gameMode.y == 0) {
      p.resumeButton();
      p.settingsButton();
    } 
    //settings menu
    else if (gameMode.y == 1) {
      s.display();
    }
  }
}

void keyPressed() {
  //modify brightness with + and -
  if (key == '+') {
    s.briScale+=.1;
  } 
  if (key == '_') {
    s.briScale-=.1;
  }
  //pause game by pressing p
  if (key == 'p') {
    gameMode = new PVector(2, 0);
  }
}

void mouseReleased() {
  //limtis cake clicks and turn ending to one mouse click per event
  for (int i = 0; i < players.length; i++) {
    players[i].c.allowRun = true;
    players[i].allowEnd = true;
  }
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j].allowRun = true;
    }
  }
}

