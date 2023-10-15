import 'dart:convert';

import 'package:dio/dio.dart';

Future<Response> getGenreName(List<int> genreIds, Dio dio) async {
  const String apiUrl = '/movie/get_genre_name';

  final Map<String, dynamic> body = {
    'ids': genreIds,
  };
  final headers = {
    'Content-Type': 'application/json',
  };

  return await dio.post(
    apiUrl,
    data: jsonEncode(body), // data instead of body
    options: Options(headers: headers),
  );
}
