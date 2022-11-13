import 'package:flutter/material.dart';
import 'package:got_app/pages/argame.dart';
import 'package:got_app/pages/home.dart';

class MessageBoxWidget {
  final String message;
  final String type;

  MessageBoxWidget({
    required BuildContext context,
    required this.message,
    required this.type,
  });

  static show(
    BuildContext context,
    String message,
    String type,
  ) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: (type == "endgame") ? MediaQuery.of(context).size.height : 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: (type == "error")
                        ? Color.fromRGBO(207, 75, 58, 1)
                        : (type == "success")
                            ? Color.fromRGBO(156, 196, 178, 1)
                            : (type == "endgame")
                                ? Color.fromARGB(255, 255, 195, 64)
                                : Colors.transparent),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("assets/icons/${type}.png"),
                      height: 40,
                      width: 40,
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                            (type == "error") ? "Oh snap ..." : "",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            message,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      .closed.then((_) {
        if(type != 'endgame'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ArGamePage()),
          );
        } else {
          //reset game

          // go to home
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );

        }
      });
  }
}
