part of 'bloc.dart';

@immutable
sealed class MovieSearchState {}

final class MovieSearchInitialState extends MovieSearchState {}

final class MoviesLoadingState extends MovieSearchState {}

final class MoviesLoadedState extends MovieSearchState {
  final List<Movie> movies;
  MoviesLoadedState({required this.movies});
}

final class MoviesErrorState extends MovieSearchState {
  final String error;

  MoviesErrorState({required this.error});

  List<Object> get props => [error];
}
