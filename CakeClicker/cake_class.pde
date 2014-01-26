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
    //increment vel.x by a noise and random based number
    vel.x += random(-1, 1)*noise(1);
    //display cake image
    imageMode(CENTER);
    ellipse(loc.x, loc.y, d, d);
    fillV(0);
    cake.resize(70, 0);
    imageV(cake, loc.x, loc.y);
  }
  void update() {
    //add vel to loc
    loc.add(vel);
    //if it goes under the display area, reassign loc and vel
    vel = (loc.y > displayHeight) ? new PVector(0, random(5, 10)) : vel;
    loc = (loc.y > displayHeight) ? new PVector(random(width), 0) : loc;
  }
}

