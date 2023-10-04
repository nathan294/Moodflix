part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class DataLoadingState extends HomeState {}

final class DataLoadedState extends HomeState {}

final class DataErrorState extends HomeState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}
