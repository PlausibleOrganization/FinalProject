PVector gameMode;
PImage soccerMom, farmer, van, cake, hole, assembly, city, grasslands, cursor, dark, rocket, machine, witch, bakery;
int tilesX = 10;
int tilesY = 10;
int tileSize = 80;
Tile[][] tiles = new Tile[tilesX][tilesY];
//player id -1 is neutral, 0 and 1 are players
Player[] players = new Player[2];
UnitData[] unitData = new UnitData[4];
TileData[] tileData = new TileData[4];
int turn;
int turnMod;
PauseMenu p;
Settings s;
StartMenu st;
Instruct in;
timer ti;
float costGrowth = 1.4;
float cityCostGrowth = 1.75;
int minCityDist = 0;
int cityFirstLevel = 2;

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
  //turnMod determines whose turn it is
  turnMod = int(gameMode.y % players.length);
  background(0);
  //what interfaces are displayed varies based on what gameMode.x is
  switch(int(gameMode.x)) {
    //starting screen, display start menu
  case 0:
    st.display();
    st.update();
    in.display();
    in.update();
    break;
    //the game itself
  case 1:
    turn = (turn == -1) ? 0 : turn;
    gameMode.y = turn;
    //update timer, display the game
    ti.time();
    displayGame();
    break;
  case 2:
    //main pause menu
    if (gameMode.y == 0) {
      //pause menu buttons
      p.resumeButton();
      p.instButton();
    } 
    break;
  case 3:
    //the intructions and rules
    in.instructions();
    break;
  case 4:
    //the lose screen
    lose();
    break;
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
  //limits cake clicks and turn ending to one mouse click per event
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

