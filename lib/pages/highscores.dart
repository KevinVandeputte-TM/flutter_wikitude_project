import 'package:flutter/material.dart';
import 'package:got_app/widgets/listtile.dart';

class HighScorePage extends StatelessWidget {
  const HighScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Highscores"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int position) {
            return const Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTileWidget(
                  avatar: "002-joker.png",
                  titletext: "This is my title",
                  subtitletext: "this is my subtitle"),
            );
          },
        ),
      ),
    );
  }
}
