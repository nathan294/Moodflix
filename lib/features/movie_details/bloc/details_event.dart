part of 'details_bloc.dart';

@immutable
sealed class MovieDetailsEvent {}

// Load the data of the movie
final class LoadDataEvent extends MovieDetailsEvent {
  final Movie movie;

  LoadDataEvent({required this.movie});
}
