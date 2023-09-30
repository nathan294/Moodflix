// ignore_for_file: use_build_context_synchronously

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
        // Parse the JSON response
        final List<dynamic> jsonResponse = responseGet.data as List<dynamic>;

        // Convert to a list of Movie objects
        final List<Movie> movies =
            jsonResponse.map((json) => Movie.fromJson(json)).toList();

        // List to hold all the prefetch image futures
        final List<Future<void>> imageFutures = [];

        for (final movie in movies) {
          if (movie.posterPath != null) {
            // Prefetch each image and add the future to the list
            final imageUrl = movie
                .posterPath; // Adjust this if necessary to get the full URL
            final imageFuture = precacheImage(NetworkImage(imageUrl!), context);
            imageFutures.add(imageFuture);
          }
          // For movies without posterPath
          const imageUrl =
              "https://e7.pngegg.com/pngimages/754/873/png-clipart-question-mark-question-mark.png"; // Adjust this if necessary to get the full URL
          final imageFuture =
              precacheImage(const NetworkImage(imageUrl), context);
          imageFutures.add(imageFuture);
        }

        // Wait for all image prefetch operations to complete
        await Future.wait(imageFutures);

        // Emit the new state with the loaded movies
        emit(MoviesLoadedState(movies: movies));

        // Send movies to our database
        Response responsePost = await sendMoviesToDatabase(movies, context);
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
