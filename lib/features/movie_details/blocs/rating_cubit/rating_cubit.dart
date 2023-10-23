import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/movie_details/data/rating.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  // Classic initial stuff
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();

  int? rating;
// initial rated status
  final Movie movie;
  RatingCubit({required this.rating, required this.movie})
      : super((rating != null) ? MovieRated(rating: rating) : MovieNotRated());

  FutureOr<void> rateMovie(int rating) async {
    emit(RatingLoading());
    try {
      Response response = await rateMovieAPI(movie.id, rating, dio);
      if (response.statusCode == 200) {
        emit(MovieRated(rating: rating));
      } else {
        emit(MovieNotRated());
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      // emit(RatingErrorState(error: e.toString()));
    }
  }

  FutureOr<void> unrateMovie(int originalRating) async {
    emit(RatingLoading());
    try {
      Response response = await unrateMovieAPI(movie.id, dio);
      if (response.statusCode == 200) {
        emit(MovieNotRated());
      } else {
        emit(MovieRated(rating: originalRating));
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      // emit(RatingErrorState(error: e.toString()));
    }
  }
}
