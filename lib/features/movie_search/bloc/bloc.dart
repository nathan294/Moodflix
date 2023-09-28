import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:moodflix/features/movie_search/data/data.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

part 'event.dart';
part 'state.dart';

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
      http.Response response = await getMovies(event.text, context);
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert to a list of Movie objects
        final List<Movie> movies =
            jsonResponse.map((json) => Movie.fromJson(json)).toList();

        // Explicitly ensure that titles are UTF-8 encoded
        final modifiedMovies = movies.map((movie) {
          final utf8Title = utf8.decode(latin1.encode(movie.title));
          return movie.copyWith(title: utf8Title);
        }).toList();

        // Emit the new state with the loaded movies
        emit(MoviesLoadedState(movies: modifiedMovies));

        http.Response responseBis =
            // ignore: use_build_context_synchronously
            await sendMoviesToDatabase(modifiedMovies, context);
        print(responseBis.statusCode);
      }
    } on Exception catch (e) {
      emit(MoviesErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onTextWipe(
      TextWipeEvent event, Emitter<MovieSearchState> emit) {
    emit(MovieSearchInitialState());
  }
}
