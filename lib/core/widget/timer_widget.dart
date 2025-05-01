import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int timeElapsed;

  const TimerWidget({super.key, required this.timeElapsed});

  @override
  Widget build(BuildContext context) {
    return Text(
      "⏱️ Time: $timeElapsed s",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
