part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class DataLoadingState extends HomeState {}

final class DataLoadedState extends HomeState {
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> upcomingMovies;

  DataLoadedState({
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.upcomingMovies,
  });
}

final class DataErrorState extends HomeState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}
