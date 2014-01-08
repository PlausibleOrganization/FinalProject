int gameMode;
PImage cake;
Clicker c;
int tilesX = 10;
int tilesY = 10;
int tileSize = 80;
Tile[][] tiles = new Tile[tilesX][tilesY];

void setup() {
  size(1000, 800);
  cake = loadImage("Cake.png");
  gameMode = 0;
  c = new Clicker();
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j] = new Tile(i, j, 0, 0);
    }
  }
}

void draw() {
  background(0);
  c.display();
  c.update();
  if (gameMode == 0) {
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        tiles[i][j].display();
      }
    }
  }
}

