//button, returns true if clicked within rectangle
boolean button(float x, float y, float w, float h) {
  if (mousePressed && mouseX > x && mouseX < x + w&& mouseY > y && mouseY < y + h) {
    return true;
  } 
  else {
    return false;
  }
}

//alternative to fill(), scales brightness by briScale
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
  fill(color(hue(c_), saturation(c_), brightness(c_)*s.briScale));
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
