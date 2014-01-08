int gameMode;
PImage cake;

void setup() {
  size(1000, 800);
  cake = loadImage("Cake.png");
  gameMode = 0;
}


void draw() {
  if (gameMode == 0) {
    for (int i = 0; i < width/80 - 2; i++) {
      for (int j = 0; j < height/80; j++) {
        colorMode(HSB, 360, 100, 100, 100);
        fill(100, 100, 100);
        rect(i * 80, j * 80, 80, 80);
      }
    }
  }
}

