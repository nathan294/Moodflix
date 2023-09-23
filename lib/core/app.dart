import 'package:flutter/material.dart';
import 'package:moodflix/config/router.dart';
import '../config/theme.dart';

import '../config/app_config.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Call AppConfig.of(context) anywhere to obtain the
    // environment specific configuration
    var config = AppConfig.of(context)!;

    return MaterialApp.router(
      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // Français
      ],

      // Verify device locale with Flutter App’s supported Locale.
      // It checks that if app supports the user’s device locale or not.
      // If not then, simply return the default English locale.
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale!.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },

      // Title of the app
      title: config.appName,

      // Theme of the app
      theme: MoodflixTheme.moodflixLightTheme,
      darkTheme: MoodflixTheme.moodflixDarkTheme,
      themeMode: ThemeMode.system,

      // Navigation
      routerConfig: router,
    );
  }
}
