import 'package:flutter/material.dart';

class AvgNoteWidget extends StatelessWidget {
  final double value; // value should be between 0 and 1

  const AvgNoteWidget({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center, // This will center align the children
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                value: value / 10, // set the value
                backgroundColor: Colors.grey[200],
                strokeWidth: 8.0,
                valueColor: AlwaysStoppedAnimation<Color>(_fillColor(value)),
              ),
            ),
            Center(
                child: Column(
              children: [
                Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, height: 1),
                ),
                const Text("Note", style: TextStyle(fontSize: 11)),
              ],
            )), // Now the Text is centered
          ],
        ),
      ],
    );
  }
}

Color _fillColor(double value) {
  if (value > 7) {
    return Colors.green;
  } else if (value > 5) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
