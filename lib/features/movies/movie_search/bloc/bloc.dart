import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:moodflix/features/movies/models/movie.dart';
import 'package:moodflix/features/movies/movie_search/data/data.dart';

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

      // Get movies list from our API
      Response<dynamic> responseGet = await getMovies(event.text, context);
      if (responseGet.statusCode == 200) {
        print(responseGet.data); // Log the response data

        // Parse the JSON response
        final List<dynamic> jsonResponse = responseGet.data as List<dynamic>;

        // Convert to a list of Movie objects
        final List<Movie> movies =
            jsonResponse.map((json) => Movie.fromJson(json)).toList();

        // Explicitly ensure that titles & overviews are UTF-8 encoded
        // final modifiedMovies = movies.map((movie) {
        //   final utf8Title = utf8.decode(latin1.encode(movie.title));
        //   final utf8Overview = utf8.decode(latin1.encode(movie.overview));
        //   return movie.copyWith(title: utf8Title, overview: utf8Overview);
        // return movie.copyWith();
        // }).toList();

        // Emit the new state with the loaded movies
        emit(MoviesLoadedState(movies: movies));

        // Send movies to our database
        Response responsePost =
            // ignore: use_build_context_synchronously
            await sendMoviesToDatabase(movies, context);
        print(responsePost);
      }
    } on Exception catch (e, s) {
      print(e); // Log the exception
      print(s); // Log the stack trace

      emit(MoviesErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onTextWipe(
      TextWipeEvent event, Emitter<MovieSearchState> emit) {
    emit(MovieSearchInitialState());
  }
}
