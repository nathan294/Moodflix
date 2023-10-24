import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/core/token_service.dart';

class DataProvider {
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();

  Future<Response> fetchWishedMovies(int skip, int limit) async {
    final tokenService = getIt<TokenService>();
    final token = await tokenService.getToken();

    String apiUrl = '/v1/user_interaction/wish?skip=$skip&limit=$limit';

    final headers = {
      'Authorization': 'Bearer $token',
    };

    return dio.get(
      apiUrl,
      options: Options(headers: headers),
    );
  }
}
