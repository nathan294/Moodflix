import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodflix/core/interceptor.dart';
import 'package:provider/provider.dart';
import 'config/app_config.dart';

Future<void> mainCommon(AppConfig configuredApp) async {
  // Update the AppConfig instance with the Firebase instance
  configuredApp.firebaseAuth = FirebaseAuth.instance;

  final dio = Dio();
  dio.interceptors.add(LoggingInterceptor()); // Add the interceptor
  runApp(
    Provider<Dio>.value(
      value: dio,
      child: configuredApp,
    ),
  );
}
