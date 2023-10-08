import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/interceptor.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

Future<void> mainCommon(
    AppConfig configuredApp, WidgetsBinding widgetsBinding) async {
  // Update the AppConfig instance with the Firebase instance
  configuredApp.firebaseAuth = FirebaseAuth.instance;

  // We use Dio for the http requests
  final dio = Dio();
  dio.interceptors.add(LoggingInterceptor()); // Add the interceptor

  // Logger
  var logger = Logger();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        Provider<Dio>.value(value: dio),
        Provider<Logger>.value(value: logger),
      ],
      child: configuredApp,
    ),
  );
}
