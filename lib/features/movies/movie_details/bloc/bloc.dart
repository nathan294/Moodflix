import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:moodflix/features/movies/movie_details/data/data.dart';

part 'event.dart';
part 'state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final BuildContext context;

  MovieDetailsBloc(this.context) : super(MovieDetailsInitial()) {
    on<MovieDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadDataEvent>(_loadMovieGenres);
  }

  FutureOr<void> _loadMovieGenres(
      LoadDataEvent event, Emitter<MovieDetailsState> emit) async {
    emit(DataLoadingState());
    try {
      // Get movies list from our API
      Response response = await getGenreName(event.genreIds, context);
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> responseData = response.data as List<dynamic>;
        final List<String> stringData =
            responseData.map((item) => item.toString()).toList();
        print(stringData);
        emit(DataLoadedState(genreName: stringData));
      }
    } on Exception catch (e) {
      emit(DataErrorState(error: e.toString()));
    }
  }
}
