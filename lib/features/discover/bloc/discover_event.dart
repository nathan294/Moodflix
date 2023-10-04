part of 'discover_bloc.dart';

@immutable
sealed class DiscoverEvent {}

final class LoadDataEvent extends DiscoverEvent {}
