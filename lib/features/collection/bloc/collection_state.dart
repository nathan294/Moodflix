part of 'collection_bloc.dart';

@immutable
sealed class CollectionState {}

final class CollectionInitial extends CollectionState {}

final class DataLoadingState extends CollectionState {}

final class FetchingState extends CollectionState {}

final class DataLoadedState extends CollectionState {
  final List<Movie> wishedMovies;
  final List<Movie> ratedMovies;
  final bool hasReachedMax;

  DataLoadedState(
      {required this.wishedMovies,
      required this.ratedMovies,
      required this.hasReachedMax});

  DataLoadedState copyWith(
      {List<Movie>? wishedMovies,
      List<Movie>? ratedMovies,
      bool? hasReachedMax}) {
    return DataLoadedState(
      wishedMovies: wishedMovies ?? this.wishedMovies,
      ratedMovies: ratedMovies ?? this.ratedMovies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class DataErrorState extends CollectionState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}
