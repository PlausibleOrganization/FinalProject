class timer {
  int newTime, oldTime, oldTurn, secspassed, firstTime, oldTime2, pauseTime;
  boolean called;

  timer(int n) {
    secspassed = n;
    oldTurn = 0;
    pauseTime = 0;
    called = false;
  }

  void time() {
    //if the turn changes, end the turn
    if (turn != oldTurn) {
      endTurn();
    }
    switch(int(gameMode.x)) {
    case 1:
      //if it's the fist turn, use firstTime to prevent glitches
      switch (turn) {
      case 0:
        if (!called) {
          firstTime = millis();
          called = true;
        }
        break;
        //if not, set newTime to current time
      default:
        firstTime = 0;
        break;
      } 
      //calculate newTime
      newTime = millis() - firstTime - pauseTime;
      //if it has been more than secspassed since the last new turn, then new turn
      if (newTime - oldTime >= secspassed) {
        //set new oldTime
        oldTime = newTime;
        //end the turn
        endTurn();
        turn++;
      }
      break;
    default:
    //calculate the length of time paused
      pauseTime = millis() - newTime - firstTime;
      break;
    }
    println(pauseTime);
  }

  //begins the next turn
  void endTurn() {
    pauseTime = 0;
    deselector();
    //set oldTurn to turn
    oldTurn = turn;
    //set oldTime to time
    oldTime = millis();
    //reset all unit movement
    for (int i = players[turnMod].units.size()-1; i > -1; i--) {
      players[turnMod].units.get(i).moved = 0;
    }
    //reset unitBought for all tiles
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        tiles[i][j].unitsBought = 0;
      }
    }
  }

  //return the time left in the turn in string
  String viewTime() {
    int t = secspassed - (newTime - oldTime); 
    int min = (t/60000);
    int sec = (t%60000)/1000;
    String secS = str(sec);
    if (secS.length() == 1) {
      secS = "0"+secS;
    }
    String time = min+":"+secS;
    return time;
  }

  boolean cakeGain() {
    //set newTime
    newTime = millis();
    //if turn == 0, set modified newTime
    if (turn == 0) {
      newTime = millis() - firstTime;
    }
    //if it's been 1 sec, return tru
    if (newTime - oldTime2 >= 1000) {
      oldTime2 = newTime;
      return true;
    } 
    //otherwise return false
    else {
      return false;
    }
  }
}

