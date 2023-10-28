String fillAverageNoteValue(double voteAverage) {
  // Convert the number to a String with 1 digit
  String numberStr = voteAverage.toStringAsFixed(1);

  // Split the string at the decimal point
  List<String> parts = numberStr.split('.');
  // Get the first digit after the decimal point
  String decimalPart = parts[1];
  int firstDecimalDigit = int.parse(decimalPart[0]);
  if (firstDecimalDigit == 0) {
    return voteAverage.toStringAsFixed(0);
  } else {
    return voteAverage.toStringAsFixed(1);
  }
}
