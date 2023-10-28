import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final double? value; // value should be between 0 and 1
  final String text;

  const NoteWidget({
    Key? key,
    required this.value,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center, // This will center align the children
          children: [
            SizedBox(
              height: 55,
              width: 55,
              child: CircularProgressIndicator(
                value: (value != null) ? (value! / 10) : 0, // set the value
                backgroundColor: Colors.grey[200],
                strokeWidth: 8.0,
                valueColor: AlwaysStoppedAnimation<Color>(_fillColor(value)),
              ),
            ),
            Center(
                child: Column(
              children: [
                Text(
                  _fillText(value),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, height: 1),
                ),
                // Text(text, style: const TextStyle(fontSize: 11)),
              ],
            )), // Now the Text is centered
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(text, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

Color _fillColor(double? value) {
  if (value == null) {
    return Colors.grey;
  } else {
    if (value > 7) {
      return Colors.green;
    } else if (value >= 5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

String _fillText(double? value) {
  if (value != null) {
    if (value % 1 == 0) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  } else {
    return "-";
  }
}
