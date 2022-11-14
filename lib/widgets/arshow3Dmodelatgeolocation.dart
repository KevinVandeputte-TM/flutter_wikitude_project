import 'dart:async';

import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:augmented_reality_plugin_wikitude/startupConfiguration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:got_app/models/armodelresponse.dart';
import 'package:got_app/pages/question.dart';

import 'package:got_app/providers/gameprovider.dart';
import 'package:got_app/providers/userprovider.dart';
import 'package:provider/provider.dart';

import '../models/flutterwikitudeexchange.dart';

//SEE https://www.wikitude.com/external/doc/documentation/latest/android/3dmodels.html#3dModelAtGeoLocation
class ARShow3DModelAtGeolocationWidget extends StatefulWidget {
  const ARShow3DModelAtGeolocationWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ARShow3DModelAtGeolocationWidgetState();
}

class _ARShow3DModelAtGeolocationWidgetState
    extends State<ARShow3DModelAtGeolocationWidget>
    with WidgetsBindingObserver {
  //AR setup
  late ArchitectWidget architectWidget;
  String wikitudeTrialLicenseKey =
      "1o9r1IvdiAVq1z5Itc+mTnxHKqHN4AJLFGFQMZIIk4KxVwyCDR98dtJ5uUjcrZs1bU5fZnZAT5sagoWz5S3L2boRuqihtgHqEv+3Qix3NK0BKJWJvMAamau231eeleBKHuaWBeLCrdxUKMSGHcr/K/O6xibZSw4Zhv/7SsWutwpTYWx0ZWRfXxLcVx9uTx497+NulVWSee290QPIHVpbDpkk6nPQCpC0N+l+EjdgJXv6fWQ2zDeF6SAmmO/YKP35y5s//QCDE4aHz9pRkXSCtP/3/7twxgg02zy1VMLG5RJDqCQThGCozQdJEcAVGTU/+HWBpK+QBa3NmDlJwljmYpW+jYn0ZJ9qgHD2oUWx0OJ8VolvwLucqwVjnGATpIHwS87koGTBCl3ZWn4CjZt7KIyXW+3DvwXF73zH7Cuvh6CubjnMzWHSNNmUQiLOhMgLfdjPyECsVzhKaJwf7ZoRziKm5BfneQNUy/Q6BeeizDMJx/q9msCHopGWcvsvFus9iVsLRTe7agXt6pRr4azx7Wcs2cCOYM1dqzMMYHd95JpTumRgo3imHQe312OTIUig7Wr6NrH/zNPkAC/hBx4Vo1G4k4UU52hyN1IiKxQaRLzPXSkAnhCzxMFwuiBnQUY0NdrAPHzm0UkKkY0jI78LABD+eV2UNbCrR2ESA441l9QcM2ufm/rck+yqH4A2gXts+TnhfWKreKFcWhXVVHJWmlRjsIpezDILwZEl12nAqCyU1hZVzCJhNF8MvARji8wK+DB0vL0f55FCZLKlMJ3vy2yU0fU0PZjzFhQc+cSDz7v2EiAzdgOqMwbPkoG+xOhaOqaYBgN8iSPEtkQQEjhUxQ==";
  StartupConfiguration startupConfiguration = StartupConfiguration(
      cameraPosition: CameraPosition.BACK,
      cameraResolution: CameraResolution.AUTO);

  //this feature is needed for multiple targets scanning
  List<String> features = ["image_tracking"];

  late StreamSubscription<Position> positionStream;

  //Initialising architectWidet
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Future.delayed(Duration(seconds: 5), () {
    architectWidget = ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: startupConfiguration,
      features: features,
    );
    getLocation();
  }

  /* GETTING THE USER LOCATION every 2 seconds*/
  Future<void> getLocation() async {
//set the locationsettings for your device
    LocationSettings locationSettings;
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        //distanceFilter: 10, //distanceFilter: the minimum distance (measured in meters) a device must move horizontally before an update event is generated;
        intervalDuration: const Duration(seconds: 10),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.best,
        activityType: ActivityType.fitness,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
      );
    }
    //Subscibe to Stream of location updates
    //start stream
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      //UPDATING THE AR.CONTEXT
      architectWidget.setLocation(position.latitude, position.longitude,
          position.altitude, position.accuracy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      side: BorderSide.none),
                  onPressed: () {
                    //close button
                    // architectWidget.pause();
                    // architectWidget.destroy();
                    closeworld();
                  },

                  icon: Icon(
                    // <-- Icon
                    Icons.close,
                    size: 25.0,
                  ),
                  label: Text('close',
                      style: TextStyle(
                        fontSize: 15.0,
                      )), // <-- Text
                )
              ])),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: architectWidget, //ar widget
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 23, 55, 70),
          child: Container(
            height: 70.0,
            margin: EdgeInsets.only(top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "LEVEL:",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(context.read<GameProvider>().getLevel.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 25.0))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "SCORE:",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(
                        context.read<UserProvider>().score.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      )
                    ],
                  )
                ]),
          ),
        ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        architectWidget.pause();
        break;
      case AppLifecycleState.resumed:
        architectWidget.resume();
        break;

      default:
    }
  }

  @override
  Future<void> dispose() async {
    await architectWidget.pause();
    await architectWidget.destroy();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> onArchitectWidgetCreated() async {
    architectWidget.load(
        "samples/07_3dModels_6_3dModelAtGeoLocation/index.html",
        onLoadSuccess,
        onLoadFailed);

    architectWidget.resume();
    architectWidget.setJSONObjectReceivedCallback(
        (result) => OnJSONObjectReceived(result));
  }

  Future<void> onLoadFailed(String error) async {}

  Future<void> onLoadSuccess() async {
    //1. load the modelitems in wikitude
    for (ModelItem item in context.read<GameProvider>().modelItems) {
      //give to JS from wikitude
      architectWidget.callJavascript(
          'World.getModelNames("${item.objectname}","${item.relativeLat}", "${item.relativeLon}")');
    }

    //2. load the startcoordinates
    StartCoordinates startcoordinates =
        context.read<GameProvider>().getStartPosition;
    architectWidget.callJavascript(
        'World.setStartPosition("${startcoordinates.lat}","${startcoordinates.lon}","${startcoordinates.alt}","${startcoordinates.acc}")');
  }

//when model is clicked => open flutter question page
  void OnJSONObjectReceived(Map<String, dynamic> jsonObject) async {
    //give modelname to flutter
    var clickedmodel = ARModelResponse.fromJson(jsonObject);
    //close the positionstream
    await positionStream.cancel();

    //await architectWidget.pause();
    //await architectWidget.destroy();
    await dispose();

    await Future.delayed(const Duration(milliseconds: 500));

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuestionPage(modelname: clickedmodel.modelname)));
  }

  void closeworld() async {
    await positionStream.cancel();
    await dispose();
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pushNamed(context, '/home');
  }
}
