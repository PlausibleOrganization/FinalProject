PVector gameMode;
PImage cake;
int tilesX = 10;
int tilesY = 10;
int tileSize = 80;
Tile[][] tiles = new Tile[tilesX][tilesY];
//player id -1 is neutral, 0 and 1 are players
Player[] players = new Player[2];
boolean mouseReleased;
float briScale;

void setup() {
  size(1000, 800);
  cake = loadImage("Cake.png");
  //x==0 is for menus, x==1 is for the game
  //y==0 is to indicate the turn during the game
  gameMode = new PVector(1, 0);
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(i);
  }
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j] = new Tile(i, j, 0, -1);
    }
  }
  briScale = 1;
}

void draw() {
  background(0);
  if (gameMode.x == 1) {
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
}
void mousePressed() {
  if (mouseButton == LEFT) {
    briScale-=.1;
  } 
  else {
    briScale+=.1;
  }
  println(briScale);
}

void mouseReleased() {
  for (int i = 0; i < players.length; i++) {
    players[i].c.allowRun = true;
    players[i].allowEnd = true;
  }
}

