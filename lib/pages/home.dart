import 'package:flutter/material.dart';
import 'package:got_app/pages/highscores.dart';
import 'package:got_app/theme/theme_const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  int _currentIndex = 0;
  final pages = const [
    HomePage(),
    HighScorePage(),
  ];

  //BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A game of thrones"),
      ),
      body: Center(
        child: 
        ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.play_arrow),
              SizedBox(
                width: 3,
              ),
              Text("Play game")
            ],
          ),
          onPressed: (){
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          _currentIndex = index,
          Navigator.push(context, MaterialPageRoute(builder: (context) => pages[_currentIndex]))
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scoreboard),
            label: "Highscores"
          ),
        ],
      ),
    );
  }

}



