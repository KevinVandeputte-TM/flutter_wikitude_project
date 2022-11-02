import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingSpinnerWidget extends StatelessWidget{

  const LoadingSpinnerWidget({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: const Color.fromRGBO(74, 82, 89, 100),
          size: 200,
        ),
      );
  }
}