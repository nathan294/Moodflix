part of 'details_bloc.dart';

@immutable
sealed class MovieDetailsEvent {}

// Load the data of the movie
final class LoadDataEvent extends MovieDetailsEvent {
  final Movie movie;

  LoadDataEvent({required this.movie});
}

// When user presses the Wishlist button
class ToggleWishlistEvent extends MovieDetailsEvent {}

// When user rates a movie
class RateMovieEvent extends MovieDetailsEvent {
  final int rating;

  RateMovieEvent(this.rating);
}
