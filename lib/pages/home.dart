import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:got_app/theme/theme_const.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 190.0,
          height: 250.0,
          color: cAccentLight,
          child: const Text("PewDiePie"),
        ),
      ),
    );
  }
}
