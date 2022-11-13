import 'package:flutter/cupertino.dart';

//bottomnavigation bar
class ScreenIndexProvider extends ChangeNotifier {
  int indexOfCurrentScreen = 0;

  int get fetchCurrentScreenIndex {
    return indexOfCurrentScreen;
  }

//set a new index of the pase you're going to
  void updateIndexOfCurrentScreen(int newIndex) {
    indexOfCurrentScreen = newIndex;
    notifyListeners();
  }
}
