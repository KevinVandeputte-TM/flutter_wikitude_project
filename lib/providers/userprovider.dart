import 'package:flutter/material.dart';
import 'package:got_app/models/user.dart';

class UserProvider extends ChangeNotifier{
  int _userid = 0;
  int _avatarID = 0;
  int _score = 0;
  String _username = "";
  

  int get userid => _userid;
  int get score => _score;
  int get avatarID => _avatarID;
  String get username => _username;

  void setUserID(int id){
    _userid = id;
    notifyListeners();
  }

  void setScore(int score){
    _score = score;
    notifyListeners();
  }

  void setAvatarID(int avatarID){
    _avatarID = avatarID;
    notifyListeners();
  }

  void setUsername(String name){
    _username = name;
    notifyListeners();
  }

}