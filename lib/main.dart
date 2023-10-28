import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/config/interceptor.dart';

import 'package:moodflix/core/injection.dart';
import 'package:dio/dio.dart';

Future<void> mainCommon(
    AppConfig configuredApp, WidgetsBinding widgetsBinding) async {
  // Initialize dependencies
  setup(configuredApp);

  // We use Dio for the http requests
  // Get Dio instances from getIt
  final dio = getIt<Dio>();
  // Add the interceptor
  dio.interceptors.add(LoggingInterceptor());

  // Make sure you initialize the date locale somewhere in your app
// You only need to do this once
  Intl.defaultLocale = 'fr_FR';
  initializeDateFormatting('fr_FR', null);

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    configuredApp,
  );
}
