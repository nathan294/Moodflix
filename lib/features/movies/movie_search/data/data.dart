import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/features/movies/models/movie.dart';

Future<http.Response> getMovies(String text, BuildContext context) async {
  return http.get(
      Uri.parse('${AppConfig.of(context)!.apiBaseUrl}/movie/?title=$text'));
}

Future<http.Response> sendMoviesToDatabase(
    List<Movie> movies, BuildContext context) async {
  final String apiUrl = '${AppConfig.of(context)!.apiBaseUrl}/movie/';

  // Serialize the list of movies to a JSON string
  String jsonMovies =
      jsonEncode(movies.map((movie) => movie.toJson()).toList());

  return http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonMovies,
  );
}
