class Plant {
  final String plantName, nickName;
  Plant(this.plantName, this.nickName);
}

class PlantList {
  static List<Plant> plantList = [];

  static List getList() {
    return plantList;
  }

  static addPlant(plant) {
    plantList.add(plant);
  }

  static removePlant(index) {
    plantList.removeAt(index);
  }

  static getInfo(index) {
    Plant plant = plantList[index];
    Map m = {
      "plant-name": plant.plantName,
      "nick-name": plant.nickName,
    };

    return m;
  }
}
