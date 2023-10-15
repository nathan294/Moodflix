part of 'collection_bloc.dart';

@immutable
sealed class CollectionEvent {}

final class LoadDataEvent extends CollectionEvent {}

final class AddMovieListEvent extends CollectionEvent {
  final String title;

  AddMovieListEvent({required this.title});
}
