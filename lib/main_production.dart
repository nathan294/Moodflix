import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/core/app.dart';

import 'config/app_config.dart';
import 'main.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var configuredApp = AppConfig(
    appName: 'Moodflix',
    flavorName: 'production',
    apiBaseUrl: 'http://163.172.164.250:9000',
    apiAnonKey: '',
    child: const MyApp(),
  );

  mainCommon(configuredApp);
}
