part of 'details_bloc.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class DataLoadingState extends MovieDetailsState {}

class DataLoadedState extends MovieDetailsState {
  final List<String> genreNames;
  final bool isWished;
  final int? rate;

  DataLoadedState(
      {required this.genreNames, required this.isWished, this.rate});
}

final class DataErrorState extends MovieDetailsState {
  final String error;

  DataErrorState({required this.error});

  List<Object> get props => [error];
}

class WishlistUpdatingState extends MovieDetailsState {}

class WishlistUpdatedState extends MovieDetailsState {
  final bool isAddedToWishlist;

  WishlistUpdatedState({required this.isAddedToWishlist});
}

class RatingUpdatingState extends MovieDetailsState {}

class RatingUpdatedState extends MovieDetailsState {
  final int rating;

  RatingUpdatedState({required this.rating});
}
