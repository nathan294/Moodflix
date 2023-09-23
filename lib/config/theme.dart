import 'package:flutter/material.dart';

class MoodflixTheme {
  static final moodflixLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Define the default brightness and colors.
    // colorScheme: ColorScheme.fromSeed(
    //     seedColor: const Color.fromARGB(255, 254, 224, 151),
    //     brightness: Brightness.light),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    // textTheme:(),
  );

  static final moodflixDarkTheme =
      ThemeData(useMaterial3: true, brightness: Brightness.dark
          // Define the default brightness and colors.
          // colorScheme: ColorScheme.fromSeed(
          //     seedColor: const Color.fromARGB(255, 254, 224, 151),
          //     background: const Color.fromARGB(255, 26, 34, 51),
          //     brightness: Brightness.dark),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          // textTheme: (),
          );
}
