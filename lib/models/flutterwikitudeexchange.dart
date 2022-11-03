class ModelItem {
  String objectname;

  double relativeLat;
  double relativeLon;
  bool isClicked;
  ModelItem({
    required this.objectname,
    required this.relativeLat,
    required this.relativeLon,
    required this.isClicked,
  });
}

class StartCoordinates {
  double lat;
  double lon;
  double alt;
  double acc;
  StartCoordinates({
    required this.lat,
    required this.lon,
    required this.alt,
    required this.acc,
  });
}
