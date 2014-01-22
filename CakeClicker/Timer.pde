class timer {
  int newTime, oldTime, oldTurn, secspassed;

  timer(int n) {
    secspassed = n;
    oldTurn = turn;
  }

  void time() {
    if (turn == 0) {
      newTime = millis() + 4000;
    } else {
     newTime = millis(); 
    }
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

