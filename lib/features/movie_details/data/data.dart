import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:provider/provider.dart';

Future<Response> getGenreName(List<int> genreIds, BuildContext context) async {
  final String apiUrl =
      '${AppConfig.of(context)!.apiBaseUrl}/movie/get_genre_name';

  final Map<String, dynamic> body = {
    'ids': genreIds,
  };
  final headers = {
    'Content-Type': 'application/json',
  };

  // Obtain the Dio instance
  final dio = context.read<Dio>();

  return await dio.post(
    apiUrl,
    data: jsonEncode(body), // data instead of body
    options: Options(headers: headers),
  );
}
