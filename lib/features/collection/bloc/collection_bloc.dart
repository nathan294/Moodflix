import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/collection/data/add_movies_list.dart';
import 'package:moodflix/features/collection/data/fetch_movies_lists.dart';
import 'package:moodflix/features/collection/models/movie_list.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();

  CollectionBloc() : super(CollectionInitial()) {
    on<CollectionEvent>((event, emit) {});
    on<LoadDataEvent>(_loadData);
    on<AddMovieListEvent>(_addMovieList);
  }

  FutureOr<void> _loadData(
      LoadDataEvent event, Emitter<CollectionState> emit) async {
    emit(DataLoadingState());
    try {
      // Retrieve movies lists
      Response<dynamic> response = await getUserMoviesLists(dio, config);

      if (response.statusCode == 200) {
        // Parse the response into a list of MovieLists
        List<dynamic> responseData = response.data as List<dynamic>;
        List<MovieList> movieLists = parseMovieLists(responseData);

        // Emit the state with the loaded movie lists
        emit(DataLoadedState(moviesLists: movieLists));
      } else {
        // Handle unexpected status code here
        emit(DataErrorState(
            error: 'Unexpected status code ${response.statusCode}'));
      }
    } on Exception catch (e, s) {
      logger.e("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error

      emit(DataErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _addMovieList(
      AddMovieListEvent event, Emitter<CollectionState> emit) async {
    // Store the previous state
    final previousState = state;

    emit(DataLoadingState());
    try {
      // Post movies list
      Response<dynamic> response =
          await addMoviesList(event.title, dio, config);
      if (response.statusCode == 200) {
        MovieList newMovieList = MovieList.fromJson(response.data);
        if (previousState is DataLoadedState) {
          final updatedMoviesLists = [
            ...previousState.moviesLists,
            newMovieList
          ];
          emit(DataLoadedState(moviesLists: updatedMoviesLists));
        }
      } else {
        emit(DataErrorState(
            error: 'Unexpected status code ${response.statusCode}'));
      }
    } on Exception catch (e, s) {
      logger.e("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error

      emit(DataErrorState(error: e.toString()));
    }
  }
}
