import 'dart:async';

import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:augmented_reality_plugin_wikitude/startupConfiguration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

  /* Attributes */
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late LocationSettings locationSettings;
  late Position position;
  late StreamSubscription<Position> positionStream;

  //Initialising architectWidet
  @override
  initState() {
    super.initState();
    checkGPS();

    WidgetsBinding.instance.addObserver(this);
    // Future.delayed(Duration(seconds: 5), () {
    architectWidget = ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: startupConfiguration,
      features: features,
    );
    //  });
  }

  //Checking GPS permissions
  Future<void> checkGPS() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      //if permission denied request permission
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('---*FLUTTER Location services are denied.');
        } else if (permission == LocationPermission.deniedForever) {
          return Future.error(
              '---*FLUTTER Location services are permanently denied.');
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        //Location Settings
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
        await getLocation();
      } else {
        return Future.error(
            '---*FLUTTER  GPS servicde is not enabled, turn on GPS location services');
      }
    }
    setState(() {});
  }

  /* GETTING THE USER LOCATION */
  Future<void> getLocation() async {
    debugPrint("---*FLUTTER GET LOCATION STARTED");
    //Subscibe to Stream of location updates
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      debugPrint("---*FLUTTER  The position: $position");
      //UPDATING THE AR.CONTEXT
      architectWidget.setLocation(position.latitude, position.longitude,
          position.altitude, position.accuracy);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: architectWidget, //ar widget
    );
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
  void dispose() {
    architectWidget.pause();
    architectWidget.destroy();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> onArchitectWidgetCreated() async {
    // await Future.delayed(Duration.zero);
    // debugPrint(        "---*FLUTTER CALL CURRENTPOSTION IN ON CREATED IN ARCHITECT WIDGET CREATED");
    // await getCurrentPosition();
    //get GPS permissions
    // debugPrint(
    //     "---*FLUTTER CALL CheckGPS IN ON CREATED IN ARCHITECT WIDGET CREATED");
    // await checkGPS();
    debugPrint("---*FLUTTER START CHECK ARCHITECTWIDGET");
    architectWidget.load(
        "samples/07_3dModels_6_3dModelAtGeoLocation/index.html",
        onLoadSuccess,
        onLoadFailed);
    architectWidget.resume();
  }

  Future<void> onLoadSuccess() async {
    debugPrint("---*FLUTTER Successfully loaded Architect World");
  }

  Future<void> onLoadFailed(String error) async {
    debugPrint("---*FLUTTER Failed to load Architect World");
    debugPrint(error);
  }
}
