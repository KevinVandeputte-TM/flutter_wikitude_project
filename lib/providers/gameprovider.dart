import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:got_app/models/flutterwikitudeexchange.dart';

import '../apis/edgeserver_api';

class GameProvider extends ChangeNotifier {
//to start the game
  bool _servicestatus = false;
  bool _haspermission = false;
  late LocationPermission _locationPermission;

  StartCoordinates _startPosition =
      StartCoordinates(lat: 0, lon: 0, alt: 0, acc: 0);

  //for game
  final List _collectedItems = [];
  final List<ModelItem> _modelItems = [];
  int _level = 1;

/*Getters */
//to start game
  bool get getServicestatus => _servicestatus;
  bool get getHasPermission => _haspermission;
  LocationPermission get getLocationpermission => _locationPermission;
  StartCoordinates get getStartPosition => _startPosition;

//game
  List get collectedItems => _collectedItems;
  List get modelItems => _modelItems;
  int get getLevel => _level;

/*Setters*/
//to start
  void setServicestatus(status) {
    _servicestatus = status;
  }

  Future<void> setHaspermission(status) async {
    _haspermission = status;

    if (_haspermission) {
      if (_startPosition.lat == 0 &&
          _startPosition.lon == 0 &&
          _startPosition.acc == 0 &&
          _startPosition.alt == 0) {
        debugPrint("WE HAVE PERMISSIONS: PROV");

        setStartPosition();
      }
    }
  }

  void setLocationPermission(status) {
    _locationPermission = status;
  }

  /* GETTING THE USER LOCATION 1 time > for setting initial position and remembering it the relaunch the wikitude environment*/
  void setStartPosition() async {
    debugPrint("2. set the StartPosition _ PROV");

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position positionStart) {
      _startPosition = StartCoordinates(
          lat: positionStart.latitude,
          lon: positionStart.longitude,
          alt: positionStart.altitude,
          acc: positionStart.accuracy);
    });
    notifyListeners();
  }

//-------------------------------------------game
  /* Set collecteditems and modelitems */
  void setCollectedItems(String objectname) {
    // add the string of the collected item into the collectedItems list
    _collectedItems.add(objectname);
    //if only one item is remaining in the modellist => level +1 and get new models?
    removeObjectFromModelItems(objectname);
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

  void removeObjectFromModelItems(String objectname) {
    if (_modelItems.length == 1) {
      _modelItems.clear();
      setLevel();
    } else {
      // remove the item form the modelitems
      _modelItems.removeWhere((item) => item.objectname == objectname);
    }
    notifyListeners();
  }

  void setLevel() async {
    _level += 1;
    //get new models if level goes up.
    await fetchModelsfromApi();
    notifyListeners();
  }

/* API calls to gather data */
  Future<void> fetchModelsfromApi() async {
    if (_modelItems.isEmpty) {
      //get level set in the provider
      await EdgeserverApi.fetchModelsByLevel(_level).then((result) {
        if (_modelItems.isEmpty) {
          /* UPDATE PROVIDER */
          result.forEach((element) {
            setModelItems(element.objectName, element.x, element.y, false);
            debugPrint("Set models in modelitems ${element.objectName}");
          });
        }
      });
    }
  }
}
