import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:provider/provider.dart';

Future<Response<dynamic>> getMovies(String text, BuildContext context) async {
  // Obtain the Dio instance
  final dio = Provider.of<Dio>(context, listen: false);
  return await dio
      .get('${AppConfig.of(context)!.apiBaseUrl}/movie/?title=$text');
}

Future<Response> sendMoviesToDatabase(
    List<Movie> movies, BuildContext context) async {
  final String apiUrl = '${AppConfig.of(context)!.apiBaseUrl}/movie/';

  // Serialize the list of movies to a JSON string
  String jsonMovies =
      jsonEncode(movies.map((movie) => movie.toJson()).toList());

  // Obtain the Dio instance
  final dio = context.read<Dio>();

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
