boolean button(float x, float y, float w, float h) {
  if (mousePressed && mouseX > x && mouseX < x + w&& mouseY > y && mouseY < y + h) {
    return true;
  } 
  else {
    return false;
  }
}

