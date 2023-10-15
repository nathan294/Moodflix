import 'package:dio/dio.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/core/token_service.dart';
import 'package:moodflix/features/collection/models/movie_list.dart';

Future<Response<dynamic>> getUserMoviesLists(Dio dio, AppConfig config) async {
  final tokenService = getIt<TokenService>();
  final token = await tokenService.getToken();
  return await dio.get(
    '/movie_list/',
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token', // Add the token to your request headers
      },
    ),
  );
}

List<MovieList> parseMovieLists(List<dynamic> jsonResponse) {
  List<MovieList> moviesLists =
      (jsonResponse).map((item) => MovieList.fromJson(item)).toList();
  return moviesLists;
}
