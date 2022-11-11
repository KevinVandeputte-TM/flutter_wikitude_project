import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingSpinnerWidget extends StatelessWidget {
  const LoadingSpinnerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.amberAccent,
        size: 200,
      ),
    );
  }
}
