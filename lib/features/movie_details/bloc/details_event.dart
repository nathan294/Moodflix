part of 'details_bloc.dart';

@immutable
sealed class MovieDetailsEvent {}

// Load the data of the movie
final class LoadDataEvent extends MovieDetailsEvent {
  final List<int> genreIds;

  LoadDataEvent({required this.genreIds});
}

// When user presses the Wishlist button
class ToggleWishlistEvent extends MovieDetailsEvent {}

// When user rates a movie
class RateMovieEvent extends MovieDetailsEvent {
  final int rating;

  RateMovieEvent(this.rating);
}
