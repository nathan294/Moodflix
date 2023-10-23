part of 'collection_bloc.dart';

@immutable
sealed class CollectionEvent {}

final class LoadDataEvent extends CollectionEvent {}
