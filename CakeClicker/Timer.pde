class timer {
  int newTime, oldTime, oldTurn, secspassed, firstTime;
  boolean called;

  timer(int n) {
    secspassed = n;
    oldTurn = 0;
    called = false;
  }

  void time() {
    if (turn != oldTurn) {
      endTurn();
    }
    switch (turn) {
    case 0:
      if (!called) {
        firstTime = millis();
        called = true;
      }
      newTime = millis() - firstTime;
      break;
    default:
      newTime = millis();
      break;
    }
    if (newTime - oldTime >= secspassed) {
      oldTime = newTime;
      endTurn();
      turn++;
    }
  }
  void endTurn() {
    deselector();
    oldTurn = turn;
    oldTime = millis();
    for (int i = players[turnMod].units.size()-1; i > -1; i--) {
      players[turnMod].units.get(i).moved = 0;
    }
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        tiles[i][j].unitsBought = 0;
      }
    }
  }
  String viewTime() {
    int t = secspassed- (newTime - oldTime); 
    int min = (t/60000)/1000;
    int sec = (t%60000)/1000;
    String secS = str(sec);
    if (secS.length() == 1) {
      secS = "0"+secS;
    }
    String time = min+":"+secS;
    return time;
  }
}

