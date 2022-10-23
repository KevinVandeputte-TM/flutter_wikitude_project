import 'package:flutter/material.dart';
import '../widgets/arshow3Dmodelatgeolocation.dart';

class ArGamePage extends StatefulWidget {
  const ArGamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArGamePageState();
}

class _ArGamePageState extends State<ArGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Go and find items"),
      ),
      body: const Center(
          // Here we load the Widget with the AR Dino experience
          child: ARShow3DModelAtGeolocationWidget()),
    );
  }
}
