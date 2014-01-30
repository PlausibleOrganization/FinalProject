//button, returns true if clicked within rectangle
boolean button(float x, float y, float w, float h) {
  return (mousePressed && mouseX > x && mouseX < x + w&& mouseY > y && mouseY < y + h) ? true : false;
}

boolean button2(float x, float y, float w, float h) {
  return (mouseX > x && mouseX < x + w&& mouseY > y && mouseY < y + h) ? true : false;
}

//alternative to fillV(), scales brightness by briScale
void fillV(float f1, float f2, float f3, float f4) {
  color c_ = color(f1, f2, f3, f4);
  colorMode(HSB, 360, 100, 100, 100);
  fill(color(hue(c_), saturation(c_), brightness(c_)*s.briScale, alpha(c_)));
}

void fillV(float f1, float f2, float f3) {
  color c_ = color(f1, f2, f3);
  colorMode(HSB, 360, 100, 100, 100);
  fill(color(hue(c_), saturation(c_), brightness(c_)*s.briScale));
}

void fillV(float f1, float f2) {
  color c_ = color(f1, f2);
  colorMode(HSB, 360, 100, 100, 100);
  fill(color(hue(c_), saturation(c_), brightness(c_)*s.briScale), alpha(c_));
}

void fillV(float f1) {
  color c_ = color(f1);
  colorMode(HSB, 360, 100, 100, 100);
  fill(color(hue(c_), saturation(c_), brightness(c_)*s.briScale));
}

//alternative to image(), scales brightness by briScale
void imageV(PImage img, float x, float y) {
  colorMode(RGB, 255, 255, 255);
  color c_ = color(255, 255, 255, 255);
  colorMode(HSB, 360, 100, 100, 100);
  tint(color(hue(c_), saturation(c_), brightness(c_)*s.briScale));
  image(img, x, y);
}

void imageV(PImage img, float x, float y, float w, float h) {
  colorMode(RGB, 255, 255, 255);
  color c_ = color(255, 255, 255, 255);
  colorMode(HSB, 360, 100, 100, 100);
  tint(color(hue(c_), saturation(c_), brightness(c_)*s.briScale));
  image(img, x, y, w, h);
}

//distance between tiles
int tileDist(Tile a, Tile b) {
  PVector dist = new PVector();
  dist.x = abs(a.tileLoc.x - b.tileLoc.x);
  dist.y = abs(a.tileLoc.y - b.tileLoc.y);
  int d = int(abs(dist.x + dist.y));
  return d;
}

//deselects all tiles and units
void deselector() {
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j].selected = false;
    }
  } 
  for (int i = 0; i < players.length; i++) {
    for (int j = players[i].units.size() - 1; j > -1; j--) {
      players[i].units.get(j).selected = false;
    }
  }
}

//display and update all tiles
void refreshTiles() {
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j].update();
      tiles[i][j].display();
    }
  }
}

//display and update all units
void refreshUnits() {
  for (int i = 0; i < players.length; i++) {
    players[i].updateUnits();
    players[i].displayUnits();
  }
}

//displays current game
void displayGame() {
  //displays ui buttons
  pauseAndQuit();
  //updates and displays all the players and tiles and units
  refreshTiles();
  players[turnMod].display();
  players[turnMod].update();
  refreshUnits();
}

//displays pretty lose screen
void lose() {
  colorMode(HSB, random(360), 100, 100);
  background(random(360), 100, 100);
  textSize(75);
  textAlign(CENTER);
  fill(random(360), 100, 100);
  switch (int(gameMode.y)) {
    //whoever lost is displayed as 
  case 0:
    translate(width/2, height/2);
    pushMatrix();
    rotate(rotation);
    text("PLAYER 1 IZ LOZER lOL", 0, 0);
    rotation+=10;
    popMatrix();
    break;
  case 1:
    translate(width/2, height/2);
    pushMatrix();
    rotate(rotation);
    text("PLAYER 2 IZ LOZER lOL", 0, 0);
    rotation+=10;
    popMatrix();
    break;
  }
}

