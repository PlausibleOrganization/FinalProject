PVector gameMode;
PImage soccerMom, farmer, van, cake, hole, assembly, city, grasslands, cursor, dark, rocket, machine, witch, bakery;
int tilesX = 10;
int tilesY = 10;
int tileSize = 80;
Tile[][] tiles = new Tile[tilesX][tilesY];
//player id -1 is neutral, 0 and 1 are players
Player[] players = new Player[2];
UnitData[] unitData = new UnitData[4];
int turn;
int turnMod;
PauseMenu p;
Settings s;
StartMenu st;
Instruct in;
timer ti;

void setup() {
  size(1000, 800);
  //construct all PImages
  constructImages();
  //x==0 is for start menu, x==1 is for the game, x==2 for pause menu
  //y==0 is to indicate the turn during the game
  gameMode = new PVector(0, 0);
initialize();
  st = new StartMenu();
  in = new Instruct();
}

void draw() {
  //turnMod is what player's turn it is
  background(0);
  //starting screen
  if (gameMode.x == 0) {
    turnMod = int(gameMode.y % players.length);
    st.display();
    st.update();
    in.display();
    in.update();
  }
  //game screens
  if (gameMode.x == 1) {
    gameMode.y = turn;
    ti.time();
    pauseAndQuit();
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        tiles[i][j].update();
        tiles[i][j].display();
      }
    }
    players[turnMod].display();
    players[turnMod].update();
    for (int i = 0; i < players.length; i++) {
      players[i].updateUnits();
      players[i].displayUnits();
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
  if (gameMode.x == 3) {
    in.instructions();
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
  //soley for debugging
  if (key == 'q') {
    players[0].cakes += 40000;
  }
  if (key == 'z') {
    players[1].cakes += 40000;
  }
}

void mouseReleased() {
  //limtis cake clicks and turn ending to one mouse click per event
  for (int i = 0; i < players.length; i++) {
    players[i].c.allowRun = true;
    players[i].allowEnd = true;
    for (int j = players[i].units.size()-1; j > -1; j--) {
      players[i].units.get(j).allowMove = true;
    }
  }
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j].allowBuy = true;
    }
  }
}

