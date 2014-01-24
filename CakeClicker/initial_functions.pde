void quit() {
  setup();
}

void initialize() {
  //construct players
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player(i);
  }
  //construct tiles
  for (int i = 0; i < tilesX; i++) {
    for (int j = 0; j < tilesY; j++) {
      tiles[i][j] = new Tile(i, j);
    }
  }
  //construct unitData
  for (int i = 0; i < unitData.length; i++) {
    unitData[i] = new UnitData(i);
  }
  //set turn to Player 1;
  turn = 0;
  //starting cities
  tiles[0][0].owner = 0;
  tiles[0][0].setCity();
  tiles[tilesX-1][tilesY-1].owner = 1;
  tiles[tilesX-1][tilesY-1].setCity();
  //construct menus
  p = new PauseMenu();
  s = new Settings();
  ti = new timer(60000);
}

