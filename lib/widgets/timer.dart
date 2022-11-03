import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

//https://github.com/DizoftTeam/simple_count_down/tree/master/example
class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: 900,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: const Duration(seconds: 1),
      onFinished: () {
        debugPrint('Timer is done!');
      },
    );
  }
}
