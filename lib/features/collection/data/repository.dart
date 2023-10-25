import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/collection/data/provider.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class Repository {
  final DataProvider dataProvider = DataProvider();
  final Logger logger = getIt<Logger>();

  Future<List<Movie>> getWishedMovies(int skip, int limit) async {
    try {
      Response response = await dataProvider.getWishedMoviesAPI(skip, limit);
      if (response.statusCode == 200) {
        dynamic data = response.data;
        List<Movie> wishedMovies =
            (data as List).map((item) => Movie.fromJson(item)).toList();
        return wishedMovies;
      } else {
        // Handle non-200 status code
        throw Exception(
            'Failed to fetch wished movies: ${response.statusCode}');
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      rethrow; // Re-throw the exception to ensure non-nullable return
    }
  }

  Future<List<Movie>> getRatedMovies(int skip, int limit) async {
    try {
      Response response = await dataProvider.getRatedMoviesAPI(skip, limit);
      if (response.statusCode == 200) {
        dynamic data = response.data;
        List<Movie> ratedMovies =
            (data as List).map((item) => Movie.fromJson(item)).toList();
        return ratedMovies;
      } else {
        // Handle non-200 status code
        throw Exception('Failed to fetch rated movies: ${response.statusCode}');
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      rethrow; // Re-throw the exception to ensure non-nullable return
    }
  }
}
