class cake {
  PVector loc;
  PVector vel;
  int d;
  PImage cake;

  cake(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 5);
    d = 20;
    cake = loadImage("Cake.png");
  }
  void display() {
    imageMode(CENTER);
    ellipse(loc.x, loc.y, d, d);
    fill(0);
    cake.resize(70, 0);
    image(cake, loc.x, loc.y);
  }
  void update() {
    loc.add(vel);
    if (loc.y > displayHeight) {
      loc.y = 0;
    }
  }
}

