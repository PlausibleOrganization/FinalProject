class Unit {
  PVector tileLoc, loc, mouseTile;
  String name;
  int atk, def, hp, maxhp;
  int range, moved;
  int owner, unitId, level, index;
  PImage img;
  boolean selected, move, allowMove;
  int imgSize;

  Unit(float owner_, float unitId_, float x, float y) {
    //deselect all other things
    deselector();
    //set data based on unitId and stuff
    selected = true;
    move = false;
    allowMove = true;
    imgSize = tileSize/2;
    owner = int(owner_);
    unitId = int(unitId_);
    level = 1;
    tileLoc = new PVector(x, y);
    loc = new PVector(x*tileSize, y*tileSize);
    moved = 0;
    index = -1;
    switch(unitId) {
    case 0:
      name = "Soccer Mom";
      img = soccerMom;
      hp = 100;
      atk = 75;
      def = 30;
      range = 3;
      break;
    case 1:
      name = "Soccer Mom Cavalry";
      img = van;
      hp = 100;
      atk = 60;
      def = 30;
      range = 6;
      break; 
    case 2:
      name = "Farmer";
      img = farmer;
      hp = 200;
      atk = 50;
      def = 50;
      range = 2;
      break; 
    case 3:
      name = "Rocket";
      img = rocket;
      hp = 1;
      atk = 300;
      def = 1;
      range = 10;
    }
    maxhp = hp;
  }

  //display unit and number
  void display() {
    displayImage();
    displayNumber();
    //if select display unitMenu
    if (selected) {
      unitMenu();
    }
  }

  //display the image
  void displayImage() {
    imageMode(CORNER);
    colorMode(RGB, 255, 255, 255);
    imageV(img, loc.x, loc.y, imgSize, imgSize);
  }

  //display the owner number
  void displayNumber() {
    textAlign(CENTER);
    textSize(imgSize);
    switch (owner) {
    case 0:
      colorMode(RGB, 255, 255, 255);
      fillV(255, 0, 0);
      break;
    case 1:
      colorMode(RGB, 255, 255, 255);
      fillV(0, 0, 255);
      break;
    }
    text(owner+1, loc.x+20, loc.y+30);
  }

  //display the menu
  void unitMenu() {
    //sets mouseTile to the tile the mouse is over
    mouseTile = new PVector(mouseX/tileSize, mouseY/tileSize);
    //display the unit control menu text and rectangle
    rectMode(CORNER);
    colorMode(RGB, 255, 255, 255);
    fillV(255);
    rect(width - 175, 250, 150, 225);
    fillV(200);
    rect(width - 50, 250, 20, 20);
    fillV(0);
    textSize(10);
    textAlign(CORNER);
    //should be formatted into one text function
    text("Owned by Player "+(owner+1)+"\nLocation: "+int(tileLoc.x)+" , "+int(tileLoc.y)+"\n"+name+"\nLevel "+level+"\nMovement: "+moved+"/"+range+"\nHealth: "+hp+"/"+maxhp+"\nATK: "+atk+" DEF:"+def, width-170, 265);
    //if the unit belongs to the turn player
    if (owner == turnMod) {
      //if the unit has used all its moves
      if (moved == range) {
        allowMove = false;
        textAlign(CORNER);
        textSize(15);
        text("YOU HAVE USED \nTHIS UNIT'S MOVES", width-170, 390);
      } 
      //if it hasn't used all its moves
      else {
        fillV(100);
        rect(width-170, 370, 140, 36);
        textAlign(CENTER);
        textSize(25);
        fillV(0);
        text("MOVE", width-100, 395);
      }
      //if the button is pressed, move = !move
      move = (button(width-170, 370, 140, 36) && allowMove) ? !move : move;
      allowMove = (button(width-170, 370, 140, 36) && allowMove) ? false : allowMove;
      //if move, run the move function
      if (move) {
        move();
      }
    } 
    //if it isn't the turn player's unit, say so
    else {
      textSize(20);
      textAlign(CORNER);
      text("THIS IS NOT \nYOUR UNIT", width-170, 390);
    }
  }

  void move() {
    //go through all the tiles
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        //if it is within moving range
        if (tileDist(tiles[int(tileLoc.x)][int(tileLoc.y)], tiles[i][j]) <= range - moved) {
          //fill based on owner of the unit
          if (owner == 0) { 
            colorMode(RGB, 255, 255, 255);
            fillV(255, 0, 0);
          } 
          else if (owner == 1) {
            colorMode(RGB, 255, 255, 255);
            fillV(0, 0, 255);
          }
          //draw rect
          rect(tiles[i][j].loc.x, tiles[i][j].loc.y, tileSize, tileSize);
          //overlay with slightly smaller image
          imageMode(CENTER);
          imageV(tiles[i][j].img, tiles[i][j].loc.x + tileSize/2, tiles[i][j].loc.y + tileSize/2, tileSize*.85, tileSize*.85);
        }
      }
    }
    //display all units belonging to all players
    imageMode(CORNER);
    for (int i = 0; i < players.length; i++) {
      for (int j = players[i].units.size()-1; j > -1; j--) {
        Unit unit = players[i].units.get(j);
        unit.displayImage();
      }
    }

    imageV(img, loc.x, loc.y, imgSize, imgSize);
    //display movement instruction
    textAlign(CENTER);
    textSize(25);
    fillV(0);
    text("Mouse over your target tile \nand press the M key to move!", tilesX*tileSize/2, tilesX*tileSize/2);
    //if the mouse is within the game area
    if (button2(0, 0, tileSize * tilesX, tileSize * tilesY)) {
      //tile1 is the tile the unit is in
      //tile2 is the target tile
      Tile tile1 = tiles[int(tileLoc.x)][int(tileLoc.y)];
      Tile tile2 = tiles[int(mouseTile.x)][int(mouseTile.y)];
      //tDist is the distance between them
      int tDist = tileDist(tile1, tile2);
      //if tile2 is within movemenet range
      if (tDist + moved <= range) {
        //if m is pressed
        if (keyPressed && (key == 'm' || key == 'M')) {
          //set move to false
          move = false;
          //if the tile is not occupied
          if (!tile2.occupied) {
            //reduce remaining moves by tDist
            moved += tDist;
            //unoccupy tile1
            tile1.occupied = false;
            //unoccupy tile2
            tile2.occupied = true;
            //set new loc and tileLoc
            tileLoc = new PVector(tile2.tileLoc.x, tile2.tileLoc.y);
            loc = new PVector(tile2.loc.x, tile2.loc.y);
            //set new unit vectors
            tile1.unit = new PVector(-1, -1);
            tile2.unit = new PVector(owner, index);
          } 
          //if the tile is occupied, then combat happens
          else {
            //unit u is the unit in the target tile
            Unit u = players[int(tile2.unit.x)].units.get(int(tile2.unit.y));
            //update all units
            for (int i = 0; i < players.length; i++) {
              for (int j = players[i].units.size()-1; j > -1; j--) {
                players[i].units.get(j).update(j);
              }
            }

            //if they don't have the same owner
            if (owner != u.owner) {
              //set power to the attacker's atk minus the defender's def
              float power = atk - u.def;
              //modify power by a random number
              power *= random(.75, 1.25);
              //if the defending unit is on 
              power = (tile2.improvement == 1) ? power / 3: power;
              //subtract power from hp
              u.hp -= int(power);
              //if the defender loses its hp
              if (u.hp <= 0) {
                //the tile is unoccupied
                tile2.occupied = false;
                //remove the unit
                players[u.owner].units.remove(u.index);
                //if the attacker is a rocket
                if (unitId == 3) {
                  //destroy the attacker
                  tile1.occupied = false;
                  players[owner].units.remove(index);
                  //update all the units that still exist
                  refreshUnits();
                }
              }
            }
          }
        }
      }
    }
  }

  //update the unit
  void update(int index_) {
    //set the argument (the index in the arrayList) to the index in the unit
    index = index_;
    //if the unit is clicked
    if (button(loc.x, loc.y, imgSize, imgSize)) {
      //run deselector
      deselector();
      //select this unit
      selected = true;
    }
    //if the x is clicked, unselect it
    selected = (selected && button(width - 50, 250, 20, 20)) ? false : selected;
  }
}

class UnitData {
  String name;
  int unitId, cost, imgSize;
  PImage img;
  PVector menuLoc;

  UnitData(int unitId_) {
    imgSize = 20;
    //select the unitData based on the unitId
    unitId = unitId_;
    switch (unitId) {
    case 0:
      name = "Soccer Mom";
      img = soccerMom;
      cost = 50;
      menuLoc = new PVector(width-170, 340);
      break;
    case 1:
      name = "Soccer Mom Cavalry";
      img = van;
      cost = 150;
      menuLoc = new PVector(width-170, 370);
      break;
    case 2:
      name = "Farmer";
      img = farmer;
      cost = 500;
      menuLoc = new PVector(width-170, 400);
      break;
    case 3:
      name = "Rocket";
      img = rocket;
      cost = 40000;
      menuLoc = new PVector(width-170, 430);
    }
  }

  void update() {
    //increase cost for the turn player as a function of their purchases
    switch (unitId) {
    case 0:
      cost = 50;
      break;
    case 1:
      cost = 150;
      break;
    case 2:
      cost = 500;
      break;
    case 3:
      cost = 40000;
    }
    cost = int(float(cost) * pow(costGrowth, players[turnMod].purchases[unitId]));
  }
}

