// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/movie_details/data/data.dart';
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
    on<LoadDataEvent>(_loadMovieDetailsData);
    on<ToggleWishlistEvent>(_toggleWishlist);
    on<RateMovieEvent>(_rateMovie);
  }

  FutureOr<void> _loadMovieDetailsData(
      LoadDataEvent event, Emitter<MovieDetailsState> emit) async {
    emit(DataLoadingState());
    try {
      // Get movie details from our API
      Response response = await getMovieDetailsData(event.movie, dio);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseData = response.data;

        // Extract genre names, wishlist status, and rating
        final List<String> genreNames =
            List<String>.from(responseData['genre_names']);
        final bool isWished = responseData['is_wished'];
        final int? rate = responseData['rate'];

        // Emit DataLoadedState with all three parameters
        emit(DataLoadedState(
            genreNames: genreNames, isWished: isWished, rate: rate));
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      emit(DataErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _toggleWishlist(
      ToggleWishlistEvent event, Emitter<MovieDetailsState> emit) async {
    emit(WishlistUpdatingState());
    try {
      // Perform API request to toggle wishlist status and get new status
      // final newStatus = await toggleWishlistAPI();

      // Emit new state with updated wishlist status
      // emit(WishlistUpdatedState(isAddedToWishlist: newStatus));
    } catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      emit(DataErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _rateMovie(
      RateMovieEvent event, Emitter<MovieDetailsState> emit) async {
    emit(RatingUpdatingState());
    try {
      // Perform API request to update the rating and get new rating
      // final newRating = await rateMovieAPI(event.rating);

      // Emit new state with updated rating
      // emit(RatingUpdatedState(rating: newRating));
    } catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error
      emit(DataErrorState(error: e.toString()));
    }
  }
}
