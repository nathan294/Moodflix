import 'package:dio/dio.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/core/token_service.dart';
import 'package:moodflix/features/collection/models/movie_list.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

Future<Response> rateMovie(
    Movie movie, MovieList movieList, int note, Dio dio) async {
  final tokenService = getIt<TokenService>();
  final token = await tokenService.getToken();
  final data = {
    'movie_id': movie.id,
    'movie_list_id': movieList.id,
    'is_note': true,
    'note': note
  };
  return await dio.post(
    '/movie_list/association',
    data: data,
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token', // Add the token to your request headers
      },
    ),
  );
}
