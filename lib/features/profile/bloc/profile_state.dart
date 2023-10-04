part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class DataLoadingState extends ProfileState {}

final class DataLoadedState extends ProfileState {}

final class DataErrorState extends ProfileState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}
