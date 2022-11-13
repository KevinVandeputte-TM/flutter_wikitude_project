import 'package:flutter/material.dart';
import 'package:got_app/pages/argame.dart';
import 'package:got_app/pages/home.dart';
import 'package:got_app/providers/gameprovider.dart';
import 'package:got_app/providers/userprovider.dart';
import 'package:provider/provider.dart';

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
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/2),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: (type == "error")
                        ? Color.fromRGBO(207, 75, 58, 0.9)
                        : (type == "success")
                            ? Color.fromRGBO(156, 196, 178, 0.9)
                            : (type == "endgame")
                                ? Color.fromARGB(255, 255, 195, 64)
                                : Colors.transparent),
                child: 
                Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon((type == "error")
                    ? Icons.thumb_down_off_alt_outlined : (type == "success") ? Icons.thumb_up_off_alt_outlined : Icons.celebration_outlined ),
                    // Image(
                    //   image: AssetImage("assets/icons/${type}.png"),
                    //   height: 40,
                    //   width: 40,
                    // ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (type == "error") ? "Oh snap ..." : "",
                            style: TextStyle(fontSize: 18, color: Color.fromRGBO(57, 79, 73, 1)),
                          ),
                          Text(
                            message,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color.fromRGBO(57, 79, 73, 0.9),
                              fontSize: 12,
                            ),
                          ),
                        ]
                      )
                    )
                  ],
                ),
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
          Provider.of<GameProvider>(context, listen: false).resetGame();
          Provider.of<UserProvider>(context, listen: false).resetUser();
          // go to home
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );

        }
      });
  }
}
