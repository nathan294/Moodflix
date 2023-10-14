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
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: config.apiBaseUrl, // Replace with your base URL
      )));
  getIt.registerLazySingleton<Logger>(() => Logger());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerSingleton<AppConfig>(config);

  // Register Blocs
  // getIt.registerFactory<AuthBloc>(() => AuthBloc());
  // getIt.registerFactory<HomeBloc>(() => HomeBloc());
  // getIt.registerFactory<ProfileBloc>(() => ProfileBloc());
  // getIt.registerFactory<CollectionBloc>(() => CollectionBloc());
  // getIt.registerFactory<DiscoverBloc>(() => DiscoverBloc());

  getIt.registerLazySingleton<TokenService>(
      () => TokenService(getIt<FlutterSecureStorage>(), getIt<FirebaseAuth>()));
}
