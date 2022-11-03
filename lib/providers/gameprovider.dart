import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier{
  final List _collectedItems = [];
  final List _modelItems = [];

  List get collectedItems => _collectedItems;
  List get modelItems => _modelItems;

  void setCollectedItems(String item){
    _collectedItems.add(item);
    notifyListeners();
  }

  void setModelItems(String item){
    _modelItems.add(item);
    notifyListeners();
  }

}