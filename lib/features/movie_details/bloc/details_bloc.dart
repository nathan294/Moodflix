import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moodflix/features/movie_details/data/data.dart';

part 'details_event.dart';
part 'details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final BuildContext context;

  MovieDetailsBloc(this.context) : super(MovieDetailsInitial()) {
    on<MovieDetailsEvent>((event, emit) {});
    on<LoadDataEvent>(_loadMovieGenres);
  }

  FutureOr<void> _loadMovieGenres(
      LoadDataEvent event, Emitter<MovieDetailsState> emit) async {
    emit(DataLoadingState());
    try {
      // Get movies list from our API
      Response response = await getGenreName(event.genreIds, context);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> responseData = response.data as List<dynamic>;
        final List<String> stringData =
            responseData.map((item) => item.toString()).toList();
        emit(DataLoadedState(genreName: stringData));
      }
    } on Exception catch (e) {
      emit(DataErrorState(error: e.toString()));
    }
  }
}
