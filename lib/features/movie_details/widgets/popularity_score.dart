import 'package:flutter/material.dart';

class PopularityScoreWidget extends StatelessWidget {
  final double value;
  const PopularityScoreWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toStringAsFixed(0),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Score de popularité",
          style: TextStyle(fontSize: 11),
        )
      ],
    );
  }
}
