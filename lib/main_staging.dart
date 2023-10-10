import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/core/app.dart';

import 'config/app_config.dart';
import 'main.dart';
import 'firebase/firebase_options_stg.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var configuredApp = AppConfig(
    appName: 'Moodflix STAGE',
    flavorName: 'staging',
    apiBaseUrl: 'http://163.172.164.250:9001/api',
    apiAnonKey: '',
    child: const MyApp(),
  );

  mainCommon(configuredApp, widgetsBinding);
}
