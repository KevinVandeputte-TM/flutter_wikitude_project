import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:got_app/models/user.dart';
import 'package:got_app/pages/gamerules.dart';
import 'package:got_app/pages/highscores.dart';
import 'package:got_app/pages/question.dart';
import 'package:got_app/providers/gameprovider.dart';
import 'package:got_app/providers/userprovider.dart';
import 'package:got_app/widgets/avatarselector.dart';
import '../apis/edgeserver_api';

import 'package:provider/provider.dart';

import 'argame.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final pages = const [HomePage(), HighScorePage(), GameRulesPage()];
  late TextEditingController usernameController;
  String _username = "";
  late int _selectedavatar;
  late LocationPermission permission;
  final _avatars = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ];

//wikitude
  List<String> features = ["image_tracking"];

  @override
  void initState() {
    super.initState();

    //permissions for camera
    _checkPermissions();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GameProvider>(context, listen: false).fetchModelsfromApi();
    });

    usernameController = TextEditingController();
    _selectedavatar = _avatars[0];
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  //BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A game of thrones"),
      ),
      body: Column(children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(
              child: Text("Username: "),
            ),
            const SizedBox(width: 12),
            Text(context.read<UserProvider>().username),
          ],
        ),
        ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.play_arrow),
                SizedBox(
                  width: 8,
                ),
                Text("Play Game")
              ],
            ),
            onPressed: () async {
              // USERNAME POP UP
              final username = await openDialog();
              if (username == null || username.isEmpty) return;

              setState(() {
                _username = username;
              });
            }),
// --------- ELEVATED BUTTON FOR TESTING PURPOSES ONLY -------------
        ElevatedButton(
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QuestionPage(
                            modelname: "EXTRA_PotionVial",
                          )));
            }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text("Test vraag")
              ],
            )),
//-------END TEST ELEVATED BUTTON ------------------------
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          if (index != _currentIndex)
            {
              _currentIndex = index,
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => pages[_currentIndex]))
            }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.scoreboard), label: "Highscores"),
          BottomNavigationBarItem(icon: Icon(Icons.rule), label: "rules"),
        ],
      ),
    );
  }

  //DIALOG FOR USERNAME
  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            children: <Widget>[
              const Text("Choose your avatar"),
              AvatarSelectorWidget(
                  selectedAvatar: _selectedavatar,
                  avatars: _avatars,
                  onAvatarSelected: (avatar) {
                    _onAvatarChanged(avatar);
                  }),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: "Username"),
                controller: usernameController,
                onSubmitted: (_) => startgame(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: startgame,
              child: const Text("Start game"),
            )
          ],
        ),
      );

  void startgame() {
    setState(() {
      _username = usernameController.text;
    });

    //Create user
    EdgeserverApi.createUser(_username, _selectedavatar).then((result){
      /* UPDATE PROVIDER */
      User u = result;
      context.read<UserProvider>().setUserData(u);
      //Navigator.of(context).pop(usernameController.text);
      //Clear usernamecontroller
      usernameController.clear();
    });

    //model en provider opvullen

    debugPrint("Wij gaan starten");
    checkDeviceCompatibility().then((value) => {
          if (value.success)
            {
              requestARPermissions().then((value) => {
                    if (value.success)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArGamePage()),
                        )
                      }
                    else
                      {
                        debugPrint("AR permissions denied"),
                        debugPrint(value.message)
                      }
                  })
            }
          else
            {debugPrint("Device incompatible"), debugPrint(value.message)}
        });
  }

  void _onAvatarChanged(avatar) {
    setState(() {
      _selectedavatar = avatar;
    });
  }

  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(features);
  }
 //Checking  permissions
  Future<void> _checkPermissions() async {
 context.read<GameProvider>().setServiceStatus(await Geolocator.isLocationServiceEnabled());

    if (context.read<GameProvider>().servicestatus) {
      //request location tracing part 1
permission =await Geolocator.checkPermission();

      //if permission denied request permission
      if (permission == LocationPermission.denied ||permission== LocationPermission.deniedForever) {
       //request location tracing part 2
        permission = await Geolocator.requestPermission();
        } else {
           context.read<GameProvider>().setPermit(true);
        }
      } else {
          context.read<GameProvider>().setPermit(true);
      }

      if ( context.read<GameProvider>().haspermit) {
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
        //call one time getstartlocation
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position positionStart) {
      context.read<GameProvider>().setAbsoluteStartCoordinates(
          positionStart.latitude,
          positionStart.longitude,
          positionStart.altitude,
          positionStart.accuracy);
    });

}
