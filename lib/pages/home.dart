import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:got_app/models/user.dart';
import 'package:got_app/pages/gamerules.dart';
import 'package:got_app/pages/highscores.dart';

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
  //navigation

  final pages = const [HomePage(), HighScorePage(), GameRulesPage()];
  late TextEditingController usernameController;
  //user and avatar
  String _username = "";
  late int _selectedavatar;
  final _avatars = [
    1,
    2,
    3,
    4,
    5,
  ];

//wikitude
  List<String> features = ["image_tracking"];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GameProvider>(context, listen: false).fetchModelsfromApi();
    });

    usernameController = TextEditingController();
    _selectedavatar = _avatars[0];
//check permissions for gps
    _checkServiceStatus();
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
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            "A game of thrones",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
                padding: EdgeInsets.all(5), //You can use EdgeInsets like above

                decoration:
                    BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                  BoxShadow(
                    color: Color(0xB3FFD640),
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                  ),
                ]),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color.fromARGB(255, 255, 195, 64),
                  ),
                  onPressed: () async {
                    // USERNAME POP UP
                    final username = await openDialog();
                    if (username == null || username.isEmpty) return;

                    setState(() {
                      _username = username;
                    });
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.play_arrow,
                    size: 30.0,
                  ),
                  label: Text('Play Game',
                      style: TextStyle(
                        fontSize: 30.0,
                      )), // <-- Text
                )),
          )),
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
    EdgeserverApi.createUser(_username, _selectedavatar).then((result) {
      /* UPDATE PROVIDER */
      User u = result;
      context.read<UserProvider>().setUserData(u);
      //Clear usernamecontroller
      usernameController.clear();
    });

    //model en provider opvullen

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

//1: check if gps service is available
  Future<void> _checkServiceStatus() async {
    var gelocatorservice = await Geolocator.isLocationServiceEnabled();
    context.read<GameProvider>().setServicestatus(gelocatorservice);

    if (gelocatorservice) {
      debugPrint("Home: Start servicestatus check: $gelocatorservice");
      var locationpermission = await Geolocator.checkPermission();
      context.read<GameProvider>().setLocationPermission(locationpermission);

      //if permission denied request permission
      if (locationpermission == LocationPermission.denied ||
          locationpermission == LocationPermission.deniedForever) {
        //give one more go to request permissions
        locationpermission = await Geolocator.requestPermission();
        if (locationpermission == LocationPermission.denied ||
            locationpermission == LocationPermission.deniedForever) {
          Future.error('---*FLUTTER Location services are denied.');
          context.read<GameProvider>().setHaspermission(false);
        }
      } else {
        context.read<GameProvider>().setHaspermission(true);
      }
    } else {
      return Future.error(
          '---*FLUTTER  GPS service is not enabled, turn on GPS location services');
    }
  }
}
