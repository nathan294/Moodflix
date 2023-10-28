import 'package:flutter/material.dart';

Color fillColor(double value, double? colorOpacity) {
  double opacity = (colorOpacity != null) ? colorOpacity : 1.0;
  if (value > 7) {
    return Colors.green.withOpacity(opacity);
  } else if (value >= 5) {
    return Colors.orange.withOpacity(opacity);
  } else {
    return Colors.red.withOpacity(opacity);
  }
}
