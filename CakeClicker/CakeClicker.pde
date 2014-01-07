int gameMode;
PImage cake;

void setup() {
  size(500,500);
  colorMode(HSB,360,100,100,100);
  textMode(CENTER);
  imageMode(CENTER);
  cake = loadImage("Cake.png");
  gameMode = 0;
  
}


void draw() {
  if (gameMode == 0) {
    
  }
  background(0);
  image(cake, width/2, height/2);
  
}
