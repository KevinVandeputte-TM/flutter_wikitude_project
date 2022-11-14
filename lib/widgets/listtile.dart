import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileWidget extends StatelessWidget {
  final String titletext;
  final String subtitletext;
  final int position;
  final String avatar;

  const ListTileWidget(
      {Key? key,
      required this.position,
      required this.titletext,
      required this.subtitletext,
      required this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(161, 186, 193, 0.90),
      child: ListTile(
        tileColor: Colors.transparent,
        leading:
            CircleAvatar(backgroundImage: AssetImage('assets/avatars/$avatar')),
        title: Text("PLACE # " + position.toString(),
            style: GoogleFonts.concertOne(
                fontSize: 15, fontWeight: FontWeight.bold)),
        subtitle: Text("$subtitletext with a $titletext"),
      ),
    );
  }
}
