// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';
import 'package:moodflix/features/movie_search/data/data.dart';

part 'search_event.dart';
part 'search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final BuildContext context;

  MovieSearchBloc(this.context) : super(MovieSearchInitialState()) {
    on<MovieSearchEvent>((event, emit) {});
    on<TextChangeEvent>(_onTextChange);
    on<TextWipeEvent>(_onTextWipe);
  }

  FutureOr<void> _onTextChange(
      TextChangeEvent event, Emitter<MovieSearchState> emit) async {
    try {
      emit(MoviesLoadingState());

      // Get movies list from our API
      Response<dynamic> responseGet = await getMovies(event.text, context);
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
        Future<Response> responsePost = sendMoviesToDatabase(movies, context);
        print(responsePost.runtimeType);
      }
    } on Exception catch (e, s) {
      context
          .read<Logger>()
          .f("Fatal log", error: e.toString(), stackTrace: s); // Log the error

      emit(MoviesErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onTextWipe(
      TextWipeEvent event, Emitter<MovieSearchState> emit) {
    emit(MovieSearchInitialState());
  }
}
