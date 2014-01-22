class timer {
  int newTime, oldTime, oldTurn, secspassed;

  timer(int n) {
    secspassed = n;
    oldTurn = turn;
  }

  void time() {
    if (turn != oldTurn) {
      oldTime = millis();
      oldTurn = turn;
    }
    newTime = millis();
    if (newTime - oldTime >= secspassed) {
      oldTime = newTime;
      oldTurn = turn;
      turn++;
    }
  }
}

