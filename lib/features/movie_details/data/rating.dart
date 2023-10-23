import 'package:dio/dio.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/core/token_service.dart';

Future<Response> rateMovieAPI(int movieId, int rating, Dio dio) async {
  final tokenService = getIt<TokenService>();
  final token = await tokenService.getToken();

  const String apiUrl = '/v1/user_interaction/wish';
  final Map<String, dynamic> body = {'movie_id': movieId, 'rating': rating};
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  return dio.post(
    apiUrl,
    data: body,
    options: Options(headers: headers),
  );
}
