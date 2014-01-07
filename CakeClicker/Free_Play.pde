class FreePlay {
  float cakes;
  float cakesClicked;
  float cakesEarned;
  float cakesPerSec;

  FreePlay() {
    cakesClicked = 0;
    cakesEarned = 0;
    cakesPerSec = 0;
    cakes = cakesClicked + cakesEarned;
  }
}

