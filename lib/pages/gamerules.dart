import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/fullscreendialog.dart';

class GameRulesPage extends StatelessWidget {
  const GameRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rules of the game"),
        ),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.center,
          // width: 190.0,
          // height: 250.0,
          // margin: const EdgeInsets.all(50.0),
          //color: Colors.blue[400],
          child: const Text(
            '''
        Start playing \n 
        Hit the start button. Quick… the time is ticking away.  
        Find as much objects around you as you can. Unlock each item by answering the question. 
        Gather your armour to defeat the end boss. \n  
        You get 15 minutes to find and unlock as many armour you find. 
        Not all armour have the same score. Some have a higher value and require more effort to unlock. 
        \n\n      
        Screen layout \n
        (1) See which level you are playing\n
        (2)	Username \n 
        (3)	Remaining time  \n 
        (4)	Stop the game \n 
        (5)	Current score of this level 
        \n
      ''',
            style: TextStyle(
                fontSize: 10.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ));
  }
  //////////////------------------END: code for pop up screen rules
}
