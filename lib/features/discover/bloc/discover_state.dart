part of 'discover_bloc.dart';

@immutable
sealed class DiscoverState {}

final class DiscoverInitial extends DiscoverState {}

final class DataLoadingState extends DiscoverState {}

final class DataLoadedState extends DiscoverState {}

final class DataErrorState extends DiscoverState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}
