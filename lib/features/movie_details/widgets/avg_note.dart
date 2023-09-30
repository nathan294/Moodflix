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
        SizedBox(
          width: 100, // adjust size as needed
          height: 100, // adjust size as needed
          child: Stack(
            alignment: Alignment.center, // This will center align the children
            children: [
              CircularProgressIndicator(
                value: value / 10, // set the value
                backgroundColor: Colors.grey[200],
                strokeWidth: 5.0,
                valueColor: AlwaysStoppedAnimation<Color>(_fillColor(value)),
              ),
              Center(
                  child: Text(
                value.toStringAsFixed(1),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )), // Now the Text is centered
            ],
          ),
        ),
        const Text("Note"),
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
