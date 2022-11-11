import 'package:flutter/cupertino.dart';

class ScreenIndexProvider extends ChangeNotifier {
  int indexOfCurrentScreen = 0;
  int get fetchCurrentScreenIndex {
    return indexOfCurrentScreen;
  }

  void updateIndexOfCurrentScreen(int newIndex) {
    indexOfCurrentScreen = newIndex;
    notifyListeners();
  }
}
