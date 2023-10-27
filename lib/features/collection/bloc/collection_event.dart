part of 'collection_bloc.dart';

@immutable
sealed class CollectionEvent {}

final class LoadInitialData extends CollectionEvent {}

final class FetchWishedDataEvent extends CollectionEvent {}

final class FetchRatedDataEvent extends CollectionEvent {}
