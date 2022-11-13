import 'package:flutter/material.dart';
import 'package:got_app/models/user.dart';
import 'package:got_app/apis/edgeserver_api';
import 'package:got_app/providers/gameprovider.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  int _userid = 0;
  int _avatarID = 0;
  int _score = 0;
  String _username = "";
  String _email = "";

  //GETTERS
  int get userid => _userid;
  int get score => _score;
  int get avatarID => _avatarID;
  String get username => _username;
  String get email => _email;

  // METHODS
  void setUserData(User user) {
    setUserID(user.userID);
    setUsername(user.name);
    setAvatarID(user.avatarID);
    setScore(user.score);
    setEmail(user.email);
  }

  void setUserID(int id) {
    _userid = id;
    notifyListeners();
  }

  void setScore(int? score) {
    _score = score!;
    notifyListeners();
  }

  void setAvatarID(int avatarID) {
    _avatarID = avatarID;
    notifyListeners();
  }

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  /* UPDATE THE PROVIDERS AND DB AFTER CORRECT ANSWER */
  void updateGame(BuildContext context, int? scoreOff, int? scoreDef,
      String modelname) async {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    //Calculate total score of user
    int total = _score + scoreOff! + scoreDef!;
    // The service needs an user object. Let's create one with score as total
    User u = User(
        userID: _userid,
        name: _username,
        email: _email,
        avatarID: _avatarID,
        score: total);
    // Send put request
    EdgeserverApi.updateUser(u).then((result) {
      // If put is successful then update the provider
      // ignore: unrelated_type_equality_checks
      if (result == true) {
        //update the score
        setScore(total);
        // Adjust the game settings when the user is updated => See GameProvider method
        gameProvider.setCollectedItems(modelname);
        // else display error message?
      } else {}
    });
  }

  // reset the provider
  void resetUser() {
    _userid = 0;
    _avatarID = 0;
    _score = 0;
    _username = "";
    _email = "";
  }
}
