import 'package:flutter/material.dart';
import 'package:got_app/pages/gamerules.dart';
import 'package:got_app/pages/highscores.dart';
import 'package:got_app/widgets/avatarselector.dart';
import 'package:got_app/apis/edgeserver_api';

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
  int _userID = 0;
  late int _selectedavatar;

  final _avatars = [
    0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
  ];

  @override
  void initState(){
    super.initState();
    usernameController = TextEditingController();
    _selectedavatar = _avatars[0];
  }

  @override
  void dispose(){
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
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(child: Text(
                "Username: "
              ),
            ),
            const SizedBox(width: 12),
            Text(_username),
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
            onPressed: () async{
              // USERNAME POP UP
              final username = await openDialog();
              if (username == null || username.isEmpty) return;

              setState(() {
                _username = username;
              });
              
              /*

              //////////////------------------START: code for pop up screen rules: WORK IF WE DONT USE PAGE BUT ONLY POP UP
              showGeneralDialog(
                context: context,
                pageBuilder: (bc, ania, anis) {
                  return FullScreenDialog(
                    h1: "Start playing",
                    p1: 'Hit the start button. Quick… the time is ticking away.  Find as much objects around you as you can. Unlock each item by answering the question. Gather your armour to defeat the end boss.                      ',
                    p2: 'You get 15 minutes to find and unlock as many armour you find. Not all armour have the same score. Some have a higher value and require more effort to unlock. ',
                    h2: "Screen layout",
                    p3: '(1)	See which level you are playing\n(2)	Username \n (3)	Remaining time  \n (4)	Stop the game \n (5)	Current score of this level \n',
                  );
                },
              );
            }
            //////////////------------------END: code for pop up screen rules
            ///
          */
            }),
        ]
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          if (index != _currentIndex){
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
      content: 
      Column(
        children: <Widget>[
          const Text("Choose your avatar"),
          AvatarSelectorWidget(
            selectedAvatar: _selectedavatar, 
            avatars: _avatars, 
            onAvatarSelected: (avatar){
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

  void startgame(){
    setState(() {
      _username = usernameController.text;
    });
    
    //Create user
    EdgeserverApi.createUser(_username, _selectedavatar).then((result){
      _userID = result.userID;
      Navigator.of(context).pop(usernameController.text);
      usernameController.clear();
    });

  }

  void _onAvatarChanged(avatar){
    setState(() {
      _selectedavatar = avatar;
    });
  }
}
