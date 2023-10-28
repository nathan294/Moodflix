import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

Future<Response<dynamic>> getMoviesByTitleAPI(
    String text, Dio dio, AppConfig config) async {
  return await dio.get('/v1/movie/?title=$text');
}

Future<Response> sendMoviesToDatabaseAPI(
    List<Movie> movies, AppConfig config, Dio dio) async {
  const String apiUrl = '/v1/movie/';

  // Serialize the list of movies to a JSON string
  String jsonMovies =
      jsonEncode(movies.map((movie) => movie.toJson()).toList());

  return await dio.post(
    apiUrl,
    data: jsonMovies,
    options: Options(
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
}

Future<void> cachePosterPath(List<Movie> movies) async {
  // Use Future.wait to process the movie list in parallel
  await Future.wait(movies
      .map((movie) => DefaultCacheManager().downloadFile(movie.posterPath)));
}

Future<void> cacheBackdropPath(List<Movie> movies) async {
  // Use Future.wait to process the movie list in parallel
  await Future.wait(movies
      .map((movie) => DefaultCacheManager().downloadFile(movie.backdropPath)));
}
