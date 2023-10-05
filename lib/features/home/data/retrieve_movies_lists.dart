// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:provider/provider.dart';

Future<Response<dynamic>> getHomeMovies(BuildContext context) async {
  // Obtain the Dio instance
  final dio = context.read<Dio>();
  return await dio
      .get('${AppConfig.of(context)!.apiBaseUrl}/movie/home_page_lists');
}

class ParsedMovies {
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> upcomingMovies;

  ParsedMovies({
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.upcomingMovies,
  });
}

Future<ParsedMovies> parseAndPrecacheMovies(
    Map<String, dynamic> jsonResponse, BuildContext context) async {
  // Load your JSON (for demonstration purposes, loading it from assets)
  // Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

  List<Movie> popularMovies = (jsonResponse['popular'] as List)
      .map((item) => Movie.fromJson(item))
      .toList();

  List<Movie> nowPlayingMovies = (jsonResponse['now_playing'] as List)
      .map((item) => Movie.fromJson(item))
      .toList();

  List<Movie> upcomingMovies = (jsonResponse['upcoming'] as List)
      .map((item) => Movie.fromJson(item))
      .toList();

  // Precache images
  cacheImages(popularMovies);
  cacheImages(nowPlayingMovies);
  cacheImages(upcomingMovies);

  return ParsedMovies(
    popularMovies: popularMovies,
    nowPlayingMovies: nowPlayingMovies,
    upcomingMovies: upcomingMovies,
  );
}

Future<void> cacheImages(List<Movie> movies) async {
  // Use Future.wait to process the movie list in parallel
  await Future.wait(movies
      .map((movie) => DefaultCacheManager().downloadFile(movie.posterPath)));
}
