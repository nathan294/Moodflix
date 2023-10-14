import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/token_service.dart';

final getIt = GetIt.instance;

void setup(AppConfig config) {
  // Register dependencies
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<Logger>(() => Logger());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerSingleton<AppConfig>(config);
  getIt.registerLazySingleton<TokenService>(
      () => TokenService(getIt<FlutterSecureStorage>(), getIt<FirebaseAuth>()));
}
