/*
void saveData() {
  JSONArray saveData = new JSONArray();
  JSONObject master = new JSONObject();
  master.setInt("master", 0);
  master.setInt("tilesX", 10);
  master.setInt("tilesY", 10);
  master.setInt("tileSize", 80);

  saveData.setJSONObject(0, master);

  for (int i = 0; i < tilesX + 1; i++) {
    for (int j = 0; j < tilesY + 1; j++) {
      JSONObject data = new JSONObject();
      data.setInt("id", tilesX*j + i + 1);
    }
  }
  saveJSONArray(saveData, "saveData.txt");
}
*/
