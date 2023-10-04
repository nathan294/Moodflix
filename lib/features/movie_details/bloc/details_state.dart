part of 'details_bloc.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class DataLoadingState extends MovieDetailsState {}

final class DataLoadedState extends MovieDetailsState {
  final List<String> genreName;

  DataLoadedState({required this.genreName});
  List<Object> get props => [genreName];
}

final class DataErrorState extends MovieDetailsState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}
