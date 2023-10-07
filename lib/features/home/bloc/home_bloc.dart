// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/features/home/data/retrieve_movies_lists.dart';
import 'package:moodflix/features/movie_search/data/data.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuildContext context;
  HomeBloc(this.context) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<LoadDataEvent>(_loadData);
  }

  FutureOr<void> _loadData(LoadDataEvent event, Emitter<HomeState> emit) async {
    emit(DataLoadingState());
    try {
      // Retrieve Home Movies
      Response<dynamic> responseGet = await getHomeMovies(context);
      if (responseGet.statusCode == 200) {
        // Parse and precache movies
        ParsedMovies parsedMovies =
            await parseAndPrecacheMovies(responseGet.data, context);

        // Emit the DataLoadedState
        emit(DataLoadedState(
          popularMovies: parsedMovies.popularMovies,
          nowPlayingMovies: parsedMovies.nowPlayingMovies,
          upcomingMovies: parsedMovies.upcomingMovies,
        ));
        FlutterNativeSplash.remove();

        // Combine all movies into a single list
        var allMovies = [
          ...parsedMovies.popularMovies,
          ...parsedMovies.nowPlayingMovies,
          ...parsedMovies.upcomingMovies
        ];

        // Send all movies to the database in a single request
        Future<Response<dynamic>> responsePost =
            sendMoviesToDatabase(allMovies, context);
        context.read<Logger>().i(responsePost.runtimeType);
      } else {
        // Handle other status codes here
        emit(DataErrorState(
            error: "Received status code ${responseGet.statusCode}"));
      }
    } on Exception catch (e, s) {
      context
          .read<Logger>()
          .f("Fatal log", error: e.toString(), stackTrace: s); // Log the error

      emit(DataErrorState(error: e.toString()));
    }
  }
}
