import 'package:dio/dio.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/core/token_service.dart';

Future<bool> addMovieToWishlistAPI(int movieId, Dio dio) async {
  final tokenService = getIt<TokenService>();
  final token = await tokenService.getToken();

  const String apiUrl = '/v1/user_interaction/wish';
  final Map<String, dynamic> body = {'movie_id': movieId};
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response = await dio.post(
    apiUrl,
    data: body,
    options: Options(headers: headers),
  );

  if (response.statusCode == 200) {
    return true; // Successfully added to the wishlist
  } else {
    return false; // Failed to add to the wishlist
  }
}

Future<bool> removeMovieFromWishlistAPI(int movieId, Dio dio) async {
  final tokenService = getIt<TokenService>();
  final token = await tokenService.getToken();

  const String apiUrl = '/v1/user_interaction/wish';
  final Map<String, dynamic> body = {'movie_id': movieId};
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response = await dio.delete(
    apiUrl,
    data: body,
    options: Options(headers: headers),
  );

  if (response.statusCode == 200) {
    return true; // Successfully removed from the wishlist
  } else {
    return false; // Failed to remove from the wishlist
  }
}
