import 'package:flutter/material.dart';
import 'package:got_app/widgets/listtile.dart';
import 'package:got_app/apis/edgeserver_api';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      return Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: const Color.fromRGBO(74, 82, 89, 100),
          size: 200,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Highscores"),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            elevation: 2.0,
            child: ListTileWidget(
                avatar: "${userList[position].avatarID}.png",
                subtitletext: "Player: ${userList[position].name}",
                titletext: "Score: ${userList[position].score}"),
          );
        },
      ),
    );
  }
}
