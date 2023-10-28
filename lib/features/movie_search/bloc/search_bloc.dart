import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:moodflix/features/movie_search/data/data.dart';

part 'search_event.dart';
part 'search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();

  MovieSearchBloc() : super(MovieSearchInitialState()) {
    on<MovieSearchEvent>((event, emit) {});
    on<TextChangeEvent>(_onTextChange);
    on<TextWipeEvent>(_onTextWipe);
  }

  FutureOr<void> _onTextChange(
      TextChangeEvent event, Emitter<MovieSearchState> emit) async {
    try {
      emit(MoviesLoadingState());

      // Get movies list from our API
      Response<dynamic> responseGet =
          await getMoviesByTitleAPI(event.text, dio, config);
      if (responseGet.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonResponse = responseGet.data as List<dynamic>;
        print('JSON Response: $jsonResponse');
        // ignore: avoid_function_literals_in_foreach_calls
        jsonResponse.forEach((json) {
          print('Parsing: $json');
          Movie.fromJson(json);
        });

        // Convert to a list of Movie objects
        final List<Movie> movies =
            jsonResponse.map((json) => Movie.fromJson(json)).toList();

        await cachePosterPath(movies);

        // Emit the new state with the loaded movies
        emit(MoviesLoadedState(movies: movies));

        // Send movies to our database
        Future<Response> _ = sendMoviesToDatabaseAPI(movies, config, dio);
      }
    } on Exception catch (e, s) {
      logger.f("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error

      emit(MoviesErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onTextWipe(
      TextWipeEvent event, Emitter<MovieSearchState> emit) {
    emit(MovieSearchInitialState());
  }
}
