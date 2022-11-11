import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String titletext;
  final String subtitletext;
  final String avatar;

  const ListTileWidget(
      {Key? key,
      required this.titletext,
      required this.subtitletext,
      required this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: ListTile(
          tileColor: Colors.transparent,
          leading: CircleAvatar(
              backgroundImage: AssetImage('assets/avatars/$avatar')),

          //   title: Text("${userList[position].firstname} ${userList[position].lastname}"),
          title: Text(titletext),
          subtitle: Text(subtitletext),
        ),
      ),
    );
  }
}
