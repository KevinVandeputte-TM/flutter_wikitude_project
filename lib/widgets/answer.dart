import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final String answer;
  final Function onAnswer;

  const AnswerWidget({Key? key, required this.answer, required this.onAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: ElevatedButton(
        onPressed: () {
          onAnswer(answer);
        },
        style: ButtonStyle(
          textStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white)),
        ),
        child: Text(answer, style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
