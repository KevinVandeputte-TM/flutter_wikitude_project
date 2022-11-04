import 'package:flutter/material.dart';
import 'package:got_app/models/flutterwikitudeexchange.dart';

import '../apis/edgeserver_api';

class GameProvider extends ChangeNotifier {
  final List _collectedItems = [];
  final List<ModelItem> _modelItems = [];
  late StartCoordinates _absoluteStartCoordinates;
  int _level = 2;

  List get collectedItems => _collectedItems;
  List get modelItems => _modelItems;
  get absoluteStartCoordinates => _absoluteStartCoordinates;
  int get level => _level;

  void setCollectedItems(String objectname) {
    _collectedItems.add(objectname);
    //if only one item is remaining in the modellist => level +1
    if (_modelItems.length == 1) {
      _modelItems.remove(objectname);
      setLevel();
    } else {
      _modelItems.remove(objectname);
    }
    notifyListeners();
  }

  void setModelItems(
      String item, double relativeX, double relativeY, bool isClicked) {
    _modelItems.add(ModelItem(
        objectname: item,
        relativeLat: relativeX,
        relativeLon: relativeY,
        isClicked: false));
    debugPrint("SETMODELITEMS:$item and is clicked$isClicked");
    notifyListeners();
  }

  void setAbsoluteStartCoordinates(
      double lat, double lon, double alt, double acc) {
    _absoluteStartCoordinates =
        StartCoordinates(lat: lat, lon: lon, alt: alt, acc: acc);
    debugPrint("GETCURRENTLOCATION - SETABSOLUTE: lat$lat");
    notifyListeners();
  }

  void setLevel() {
    _level += 1;
    notifyListeners();
  }

  Future<void> fetchModelsfromApi() async {
    debugPrint("Fetchmodelsbylevelprovider");
    //   setModelItems("e.objectName", 4.5, 5.4, false);
    //get level set in the provider
    await EdgeserverApi.fetchModelsByLevel(_level).then((result) {
      /* UPDATE PROVIDER */
      result.forEach((element) {
        setModelItems(element.objectName, element.x, element.y, false);
      });
    });
  }
}
