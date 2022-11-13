import 'package:flutter/material.dart';
import 'package:got_app/pages/gamerules.dart';
import 'package:got_app/pages/highscores.dart';
import 'package:got_app/pages/home.dart';
import 'package:got_app/providers/screenindexprovider.dart';
import 'package:provider/provider.dart';

class BottomBarWidget extends StatelessWidget {
  //Pages in bottom navigation
  final pages = [HomePage(), HighScorePage(), GameRulesPage()];

  @override
  Widget build(BuildContext context) {
    //listen to changes
    final _screenindexprovider = Provider.of<ScreenIndexProvider>(context);
//GET currentScreenindex from provider
    int currentScreenIndex = _screenindexprovider.fetchCurrentScreenIndex;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreenIndex,
        backgroundColor: Color(0xFF394F49),
        // showSelectedLabels: false,
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 255, 195, 64)),
        selectedItemColor: Colors.amberAccent,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedItemColor: Colors.white,
        onTap: (value) =>
            //if a button is hit => update the index in the provider
            _screenindexprovider.updateIndexOfCurrentScreen(value),
        items: [
          //Page HOME
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          //Page Highscores
          BottomNavigationBarItem(
              icon: Icon(Icons.scoreboard), label: "Highscores"),
          //Page Rules
          BottomNavigationBarItem(icon: Icon(Icons.rule), label: "rules"),
        ],
      ),
      body: pages[currentScreenIndex],
    );
  }
}
