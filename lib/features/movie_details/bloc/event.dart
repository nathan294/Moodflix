part of 'bloc.dart';

@immutable
sealed class MovieDetailsEvent {}

final class LoadDataEvent extends MovieDetailsEvent {
  final List<int> genreIds;

  LoadDataEvent({required this.genreIds});
}
