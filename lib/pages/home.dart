import 'package:flutter/material.dart';
import 'package:got_app/pages/gamerules.dart';
import 'package:got_app/pages/highscores.dart';
import 'package:got_app/widgets/fullscreendialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final pages = const [HomePage(), HighScorePage(), GameRulesPage()];

  //BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A game of thrones"),
      ),
      body: Center(
        child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.play_arrow),
                SizedBox(
                  width: 3,
                ),
                Text("play game")
              ],
            ),
            onPressed: () {
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          _currentIndex = index,
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pages[_currentIndex]))
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
}
