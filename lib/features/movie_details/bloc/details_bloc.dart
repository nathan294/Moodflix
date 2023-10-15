// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/collection/models/movie_list.dart';
import 'package:moodflix/features/movie_details/data/data.dart';
import 'package:moodflix/features/movie_details/data/rating.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

part 'details_event.dart';
part 'details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final Movie movie;
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();

  MovieDetailsBloc(this.movie) : super(MovieDetailsInitial()) {
    on<MovieDetailsEvent>((event, emit) {});
    on<LoadDataEvent>(_loadMovieGenres);
    on<RateMovieEvent>(_rateMovie);
    on<WishlistMovieEvent>(_wishlistMovie);
    on<CustomListMovieEvent>(_customListMovie);
  }

  FutureOr<void> _loadMovieGenres(
      LoadDataEvent event, Emitter<MovieDetailsState> emit) async {
    emit(DataLoadingState());
    try {
      // Get movies list from our API
      Response response = await getGenreName(event.genreIds, dio);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> responseData = response.data as List<dynamic>;
        final List<String> stringGenres =
            responseData.map((item) => item.toString()).toList();
        emit(DataLoadedState(genreName: stringGenres));
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      emit(DataErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _rateMovie(
      RateMovieEvent event, Emitter<MovieDetailsState> emit) async {
    emit(DataLoadingState());
    try {
      Response response =
          await rateMovie(movie, event.movieList, event.note, dio);
      if (response.statusCode == 200) {
        logger.i("Movie successfully rated");
        // RELOAD MOVIES DATA
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      emit(DataErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _wishlistMovie(
      WishlistMovieEvent event, Emitter<MovieDetailsState> emit) {}

  FutureOr<void> _customListMovie(
      CustomListMovieEvent event, Emitter<MovieDetailsState> emit) {}
}
