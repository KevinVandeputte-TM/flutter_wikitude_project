import 'package:flutter/material.dart';

class GameRulesPage extends StatelessWidget {
  const GameRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: const Text(
              "Rules of the game",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Container(
                      color: Color.fromRGBO(156, 196, 178, 0.75),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              const Text(
                                " Start playing",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30),
                              const Text("Hit the start button.",
                                  style: TextStyle(
                                      fontFamily: 'Yeseva One',
                                      fontSize: 15,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                              SizedBox(height: 15),
                              const Text(" Quick… ",
                                  style: TextStyle(
                                      fontFamily: 'Yeseva One',
                                      fontSize: 15,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 15),
                              const Text("The time is ticking away.   ",
                                  style: TextStyle(
                                    fontFamily: 'Yeseva One',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  )),
                              SizedBox(height: 15),
                              const Text(
                                  "Find as much objects around you as you can. Unlock each item by answering the question. Gather your armour to defeat the end boss.",
                                  style: TextStyle(
                                      fontFamily: 'Yeseva One',
                                      fontSize: 15,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                              SizedBox(height: 15),
                              const Text(
                                  " Not all armour have the same score. Some have a higher value and require more effort to unlock.",
                                  style: TextStyle(
                                      fontFamily: 'Yeseva One',
                                      fontSize: 15,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ]),
                      ),
                    )))));
  }
}
