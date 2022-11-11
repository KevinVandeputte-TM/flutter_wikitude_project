import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:got_app/pages/home.dart';
import '../widgets/arshow3Dmodelatgeolocation.dart';

class ArGamePage extends StatefulWidget {
  const ArGamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArGamePageState();
}

class _ArGamePageState extends State<ArGamePage> {
  ARShow3DModelAtGeolocationWidget arworld = ARShow3DModelAtGeolocationWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              const Text(
                "Look around to find items",
                textAlign: TextAlign.center,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, side: BorderSide.none),
                onPressed: () {
                  SystemChannels.platform.invokeMethod("SystemNavigator.pop");
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // );
                },
                icon: Icon(
                  // <-- Icon
                  Icons.house,
                  size: 30.0,
                ),
                label: Text('HOME',
                    style: TextStyle(
                      fontSize: 15.0,
                    )), // <-- Text
              )
            ])),
      ),
      body: Center(child: ARShow3DModelAtGeolocationWidget()),
    );
  }
}
