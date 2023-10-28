import 'package:dio/dio.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/core/token_service.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

Future<Response> getMovieDetailsDataAPI(Movie movie, Dio dio) async {
  final tokenService = getIt<TokenService>();
  final token = await tokenService.getToken();

  final String apiUrl = '/v1/movie/details/${movie.id}';

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Add the token to your request headers
  };

  return await dio.get(
    apiUrl,
    options: Options(headers: headers),
  );
}
