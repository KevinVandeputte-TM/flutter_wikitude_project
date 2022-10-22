import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenDialog extends StatelessWidget {
  final String h1, h2;
  final String p1, p2, p3;

//optional parameters
  const FullScreenDialog(
      {super.key,
      this.h1 = "",
      this.p1 = "",
      this.h2 = "",
      this.p2 = "",
      this.p3 = ""});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A game of thrones"),
      ),
      body: Center(
        child: SizedBox.expand(
          child: Container(
            //color:,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //////////////------------------ADD STYLING
                  Text(h1),
                  Text(p1),
                  Text(p2),
                  Text(h2),
                  Text(p3),

                  //////////////------------------TO BE REPLACED BY WIDGET KEVIN
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"))
                  //////////////------------------END:
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
