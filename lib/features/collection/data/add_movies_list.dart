import 'package:dio/dio.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/core/token_service.dart';

Future<Response<dynamic>> addMoviesList(
    String title, Dio dio, AppConfig config) async {
  final tokenService = getIt<TokenService>();
  final token = await tokenService.getToken();
  return await dio.post(
    '/movie_list/',
    data: {'title': title},
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token', // Add the token to your request headers
      },
    ),
  );
}
