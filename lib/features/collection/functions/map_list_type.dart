import 'package:moodflix/core/enum/movie_list_type.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

List<Movie> getMoviesList(CollectionState state, MovieListType type) {
  if (state is DataLoadedState) {
    return type == MovieListType.wishedMovies
        ? state.wishedMovies
        : state.ratedMovies;
  }
  return [];
}

bool hasReachedMax(CollectionState state, MovieListType type) {
  if (state is DataLoadedState) {
    return type == MovieListType.wishedMovies
        ? state.hasReachedMaxWished
        : state.hasReachedMaxRated;
  }
  return false;
}

CollectionEvent fetchEvent(MovieListType type) {
  return type == MovieListType.wishedMovies
      ? FetchWishedDataEvent()
      : FetchRatedDataEvent();
}
