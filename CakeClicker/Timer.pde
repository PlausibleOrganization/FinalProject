class timer {
  int newTime, oldTime, oldTurn, secspassed, firstTime;
  boolean called;

  timer(int n) {
    secspassed = n;
    oldTurn = 0;
    called = false;
  }

  void time() {
    if (!called) {
      firstTime = millis();
      called = true;
    }
    newTime = millis() - firstTime;
    //  }
    if (turn != oldTurn) {
      oldTime = millis();
      endTurn();
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
  }
  String viewTime() {
    int t = secspassed- (newTime - oldTime); 
    int min = (t/60000)/1000;
    int sec = (t%60000)/1000;
    String time = min+":"+sec;
    return time;
  }
}

