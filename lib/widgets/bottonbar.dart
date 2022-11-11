import 'package:flutter/material.dart';
import 'package:got_app/pages/gamerules.dart';
import 'package:got_app/pages/highscores.dart';
import 'package:got_app/pages/home.dart';
import 'package:got_app/providers/screenindexprovider.dart';
import 'package:provider/provider.dart';

class BottomBarWidget extends StatelessWidget {
  final pages = [HomePage(), HighScorePage(), GameRulesPage()];

  @override
  Widget build(BuildContext context) {
    //listen to changes
    final _screenindexprovider = Provider.of<ScreenIndexProvider>(context);

    int currentScreenIndex = _screenindexprovider.fetchCurrentScreenIndex;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreenIndex,
        backgroundColor: Color(0xFF394F49),
        showSelectedLabels: false,
        selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
        selectedItemColor: Colors.amberAccent,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedItemColor: Colors.white,
        onTap: (value) =>
            _screenindexprovider.updateIndexOfCurrentScreen(value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.scoreboard), label: "Highscores"),
          BottomNavigationBarItem(icon: Icon(Icons.rule), label: "rules"),
        ],
      ),
      body: pages[currentScreenIndex],
    );
  }
}
