import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/core/app.dart';
import 'package:moodflix/core/bloc_observer.dart';

import 'config/app_config.dart';
import 'firebase/firebase_options_dev.dart';
import 'main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();

  var configuredApp = AppConfig(
    appName: 'Moodflix DEV',
    flavorName: 'development',
    apiBaseUrl:
        // 'http://10.0.2.2:8000', // Localhost equivalent for mobile emulator
        "http://192.168.1.28:9000", // For external device
    apiAnonKey: '',
    child: const MyApp(),
  );

  mainCommon(configuredApp);
}
