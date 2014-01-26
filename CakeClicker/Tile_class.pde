class Tile {
  PVector loc, tileLoc, nearestCity, unit;
  int size, improvement, owner, level, unitsBought, cityDist;
  boolean selected, occupied, allowBuy;
  String name;
  PImage img;

  Tile(int loci, int locj) {
    selected = false;
    occupied = false;
    allowBuy = false;
    owner = -1;
    improvement = 0;
    size = tileSize;
    tileLoc = new PVector(loci, locj);
    loc = new PVector(loci*size, locj*size);
    cityDist = tilesX + tilesY;
    unit = new PVector(-1, -1);
  }

  void display() {
    imageMode(CORNER);
    colorMode(HSB, 360, 100, 100);
    //set tint by owner
    if (owner == -1) {
      tint(0, 0, 100*s.briScale, 100);
    } 
    else if (owner == 0) {
      tint(0, 50, 100*s.briScale, 50);
    } 
    else if (owner == 1) {
      tint(240, 50, 100*s.briScale, 50);
    }
    //display the tile img
    image(img, loc.x, loc.y, tileSize, tileSize);
    rectMode(CORNER);
    //if it is selected, show the tile menu
    if (selected) {
      tileMenu();
    }
  }

  //make the tile a city
  void setCity() {
    improvement = cityDist >= minCityDist ? 1 : 0;
  }

  //displays menu to ugrade tiles/buy units
  void tileMenu() {
    //display tile interface box
    colorMode(HSB, 255, 255, 255);
    fillV(255);
    rect(width - 175, 250, 150, 225);
    fillV(200);
    rect(width - 50, 250, 20, 20);
    fillV(0);
    textSize(10);
    textAlign(CORNER);
    //display owner
    switch (owner) {
    case -1:
      text("Unclaimed territory", width-170, 265);
      break;
    default:
      text("Owned by Player "+(owner+1), width-170, 265);
      break;
    }
    text("Location: "+int(tileLoc.x)+" , "+int(tileLoc.y), width-170, 280);
    text(name, width-170, 295);
    //display level
    if (level > 0) {
      text("Level "+level, width-170, 310);
    } 
    else {
      text("Undeveloped tile", width-170, 310);
    }
    //if the turn player is the owner
    if (owner == turnMod) {
      //if the territory is undeveloped, allow tile upgrades to be purchased
      if (improvement == 0) {
        textSize(15);
        text("Upgrade tile:", width-170, 330);
        imageMode(CORNER);
        //go through all the kinds of units
        for (int i = 0; i <unitData.length; i++) {
          //update tileData
          tileData[i].update();
          //display the tile thumbnail
          rect(tileData[i].menuLoc.x, tileData[i].menuLoc.y, tileData[i].imgSize, tileData[i].imgSize);
          imageV(tileData[i].img, tileData[i].menuLoc.x, tileData[i].menuLoc.y, tileData[i].imgSize, tileData[i].imgSize);
          //allow city if it's farther than the minCityDist
          if (i == 0 && cityDist < minCityDist) {
            textSize(8);
            text("YOU MAY NOT SETTLE HERE", tileData[i].menuLoc.x + tileData[i].imgSize + 10, tileData[i].menuLoc.y + tileData[i].imgSize/2);
          } 
          //for all other improvements, always allow
          else {
            //display cost and cps
            textSize(8);
            text(tileData[i].cost+"\nCPS: "+tileData[i].cps, tileData[i].menuLoc.x + tileData[i].imgSize + 10, tileData[i].menuLoc.y + tileData[i].imgSize/2 - 5);
            //if the thumbnail is clicked, and you have enough cakes
            if (button(tileData[i].menuLoc.x, tileData[i].menuLoc.y, tileData[i].imgSize, tileData[i].imgSize) && players[turnMod].cakes >= tileData[i].cost) {
              if ((tileData[i].improvement == 1 && cityDist >= minCityDist) || tileData[i].improvement != 1) {
                //subtract assign the cost
                players[turnMod].cakes-=tileData[i].cost;
                //set improvement
                improvement = tileData[i].improvement;
                //set img
                img = tileData[i].img;
                //run deselector()
                deselector();
                //increase the number of cities bought if it was a city that was bought
                if (i == 0) {
                  players[turnMod].citiesPurchased++;
                }
              }
            }
          }
        }
      }
      //if it is a city, allow units to be purchased
      else if (improvement == 1) {
        //if a unit hasn't been bought already
        if (unitsBought < 1) {
          //if the tile is occupied
          if (occupied) {
            textSize(25);
            text("This tile \nis \noccupied.", width-170, 335);
          } 
          //if the tile isn't occupied, allow units to be purchased
          else {
            //display unit text
            textSize(15);
            text("Purchase a unit:", width-170, 330);
            imageMode(CORNER);
            for (int i = 0; i <unitData.length; i++) {
              //update unit dat
              unitData[i].update();
              //display unit thumbnail and cost
              textSize(10);
              rect(unitData[i].menuLoc.x, unitData[i].menuLoc.y, unitData[i].imgSize, unitData[i].imgSize);
              imageV(unitData[i].img, unitData[i].menuLoc.x, unitData[i].menuLoc.y, unitData[i].imgSize, unitData[i].imgSize);
              textSize(10);
              text(unitData[i].cost, unitData[i].menuLoc.x + unitData[i].imgSize + 10, unitData[i].menuLoc.y + unitData[i].imgSize/2);
              //if the thumbnail is clicked and the player has enough cakes and the tile isn't occupied
              if (button(unitData[i].menuLoc.x, unitData[i].menuLoc.y, unitData[i].imgSize, unitData[i].imgSize) && players[turnMod].cakes >= unitData[i].cost && !occupied) {
                //increase purchases
                players[turnMod].purchases[i]++;
                //subtract assign the costs to cake
                players[turnMod].cakes-=unitData[i].cost;
                //add the new unit
                players[turnMod].units.add(new Unit(turnMod, i, int(tileLoc.x), int(tileLoc.y)));
                //increase the units bought
                unitsBought++;
                //make the tile occupied
                occupied = true;
                //set the unit PVector to the unit's info
                unit.x = owner;
                unit.y = players[turnMod].units.size()-1;
                //deselect things
                deselector();
              }
            }
          }
        }
      }
      //don't allow unit purchasing if a unit has been bought
      else if (improvement == 1) {
        textSize(25);
        text("You have \nalready \npurchased \na unit.", width-170, 335);
      }
    }
  }

  //update the tile
  void update() {
    //update info by improvement
    switch (improvement) {
    case 0:
      img = grasslands;
      name = "Grassland";
      level = 0;
      break;
    case 1:
      img = city;
      name = "City";
      level = (level == 0) ? cityFirstLevel : level;
      for (int i = 0; i < tilesX; i++) {
        for (int j = 0; j < tilesY; j++) {
          if (tiles[i][j].improvement != 1) {
            tiles[i][j].owner = tileDist(tiles[int(tileLoc.x)][int(tileLoc.y)], tiles[i][j]) <= level ? owner : tiles[i][j].owner;
          }
        }
      }
      break;
    case 2:
      name = "Bakery";
      level = (level == 0) ? 1 : level;
    case 3:
      name = "Space Machine";
      level = (level == 0) ? 1 : level;
    case 4:
      name = "WITCHCRAFT MAGIC";
      level = (level == 0) ? 1 : level;
    }
    //if a unit is clicked, select it
    if (button(loc.x, loc.y, tileSize, tileSize) &&!(button(loc.x, loc.y, tileSize/2, tileSize/2) && occupied)) {
      deselector();
      selected = true;
    } 
    //if selected, have the x to unselect
    if (selected) {
      if (button(width - 50, 250, 20, 20)) {
        selected = false;
      }
    }
    //calculate cityDist as the tileDist() to the nearest city
    owner = (occupied && owner != -1 && owner != unit.x && improvement == 1) ? int(unit.x) : owner;
    int cityDist_ = tilesX + tilesY;
    for (int i = 0; i < tilesX; i++) {
      for (int j = 0; j < tilesY; j++) {
        if ((new PVector(i, j)) != tileLoc) {
          if (tiles[i][j].improvement == 1) {
            if (tileDist(tiles[i][j], tiles[int(tileLoc.x)][int(tileLoc.y)]) < cityDist_) {
              cityDist_ = tileDist(tiles[i][j], tiles[int(tileLoc.x)][int(tileLoc.y)]);
            }
          }
        }
      }
    }
    cityDist = cityDist_;
  }
}

class TileData {
  int cps;
  String name;
  int improvement, cost, imgSize;
  PImage img;
  PVector menuLoc;

  TileData(int improvement_) {
    imgSize = 20;
    improvement = improvement_;
    //determine the info of the tile based on improvement
    switch (improvement) {
    case 1:
      cps = 1;
      img = city;
      cost = 500;
      menuLoc = new PVector(width-170, 340);
      break;
    case 2:
      cps = 10;
      img = bakery;
      cost = 250;
      menuLoc = new PVector(width-170, 370);
      break;
    case 3:
      cps = 100;
      img = machine;
      cost = 4000;
      menuLoc = new PVector(width-170, 400);
      break;
    case 4:
      cps = 500;
      img = witch;
      cost = 15000;
      menuLoc = new PVector(width-170, 430);
    }
  }

  void update() {
    //if it's a city, update cost as a function of citiesPurchased
    if (improvement == 1) {
      cost = int(float(500) * pow(cityCostGrowth, players[turnMod].citiesPurchased));
    }
  }
}

