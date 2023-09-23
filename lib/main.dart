import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'config/app_config.dart';

Future<void> mainCommon(AppConfig configuredApp) async {
  // Update the AppConfig instance with the Firebase instance
  configuredApp.firebaseAuth = FirebaseAuth.instance;

  runApp(configuredApp);
}
