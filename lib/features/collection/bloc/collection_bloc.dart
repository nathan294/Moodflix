import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/collection/data/repository.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();
  final Repository repository = Repository();
  final int numberOfItemsPerFetch = 10;

  CollectionBloc() : super(CollectionInitial()) {
    on<CollectionEvent>((event, emit) {});
    on<LoadInitialData>(_loadInitialData);
    on<FetchWishDataEvent>(_fetchWishData);
  }

  FutureOr<void> _loadInitialData(
      LoadInitialData event, Emitter<CollectionState> emit) async {
    emit(DataLoadingState());
    try {
      List<Movie> wishedMovies =
          await repository.getWishedMovies(0, numberOfItemsPerFetch);
      emit(DataLoadedState(
          wishedMovies: wishedMovies,
          ratedMovies: const [],
          hasReachedMax: false));
    } on Exception catch (e, s) {
      logger.e("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error

      emit(DataErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _fetchWishData(
      FetchWishDataEvent event, Emitter<CollectionState> emit) async {
    DataLoadedState currentState = state as DataLoadedState;
    emit(FetchingState());
    try {
      List<Movie> wishedMovies = await repository.getWishedMovies(
          currentState.wishedMovies.length, numberOfItemsPerFetch);
      if (wishedMovies.isEmpty) {
        emit(currentState.copyWith(hasReachedMax: true));
      } else if (wishedMovies.length != numberOfItemsPerFetch) {
        emit(currentState.copyWith(
            wishedMovies: currentState.wishedMovies + wishedMovies,
            hasReachedMax: true));
      } else {
        emit(currentState.copyWith(
            wishedMovies: currentState.wishedMovies + wishedMovies,
            hasReachedMax: false));
      }
    } on Exception catch (e, s) {
      logger.e("Fatal log",
          error: e.toString(), stackTrace: s); // Log the error

      emit(DataErrorState(error: e.toString()));
    }
  }
}
