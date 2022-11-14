import 'package:flutter/material.dart';
import 'package:got_app/widgets/listtile.dart';
import 'package:got_app/apis/edgeserver_api';
import 'package:got_app/widgets/loadingspinner.dart';

import '../models/user.dart';

class HighScorePage extends StatefulWidget {
  const HighScorePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HighScorePageState();
}

//2.we need to create the state.
class _HighScorePageState extends State {
  //state-properties
  List<User> userList = [];
  int count = 0;
  bool _isLoading = true; //bool variable created

  @override
  void initState() {
    super.initState();
    _getScores();
  }

  // Get highscores
  void _getScores() async {
    EdgeserverApi.fetchScore().then((result) {
      setState(() {
        userList = result;
        count = result.length;
        _isLoading = false;
      });
    });
  }

  //3.the build() method that will actually create the UI
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingSpinnerWidget();
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: const Text(
              "TOP 5 Highscores",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTileWidget(
                    position: position + 1,
                    avatar: "${userList[position].avatarID}.png",
                    subtitletext: "Player: ${userList[position].name}",
                    titletext: "Score: ${userList[position].score}"),
              );
            },
          ),
        ));
  }
}
