part of 'collection_bloc.dart';

@immutable
sealed class CollectionState {}

final class CollectionInitial extends CollectionState {}

final class DataLoadingState extends CollectionState {}

final class DataLoadedState extends CollectionState {
  final List<MovieList> moviesLists;

  DataLoadedState({required this.moviesLists});
}

final class DataErrorState extends CollectionState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}
