import 'package:flutter/material.dart';

typedef MyCallback = void Function(int avatarID);

class AvatarSelectorWidget extends StatelessWidget{
  final int selectedAvatar;
  final List<int> avatars;
  final MyCallback onAvatarSelected;

  const AvatarSelectorWidget(
    {Key? key,
    required this.selectedAvatar,
    required this.avatars,
    required this.onAvatarSelected})
    : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 100,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(width: 1),
          )
        ),
      items: avatars.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Image(
            image: AssetImage("assets/avatars/" + e.toString() +".png"),
            width: 40.0,
            height: 40.0
          )
        );
      }).toList(),
      value: selectedAvatar,
      onChanged: (value) {
        onAvatarSelected(value!);
      },
    )
  );
    
  }

}