class cake {
  PVector loc;
  PVector vel;
  int d;
  PImage cake;

  cake(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, random(5, 10));
    d = 20;
    cake = loadImage("Cake.png");
  }
  void display() {
    vel.x += random(-1, 1)*noise(1);
    imageMode(CENTER);
    ellipse(loc.x, loc.y, d, d);
    fillV(0);
    cake.resize(70, 0);
    imageV(cake, loc.x, loc.y);
  }
  void update() {
    loc.add(vel);
    vel = (loc.y > displayHeight) ? new PVector(0, random(5, 10)) : vel;
    loc = (loc.y > displayHeight) ? new PVector(random(width), 0) : loc;
  }
}

