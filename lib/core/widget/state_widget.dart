import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final int matchedPairs;
  final int totalFlips;

  const StatsWidget({super.key, required this.matchedPairs, required this.totalFlips});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("🎯 Flips: $totalFlips", style: TextStyle(fontSize: 20)),
        SizedBox(width: 20),
        Text("✅ Matches: $matchedPairs / 5", style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
