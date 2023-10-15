part of 'details_bloc.dart';

@immutable
sealed class MovieDetailsEvent {}

// Load the data of the movie
final class LoadDataEvent extends MovieDetailsEvent {
  final List<int> genreIds;

  LoadDataEvent({required this.genreIds});
}

// When the user rates a movie
final class RateMovieEvent extends MovieDetailsEvent {
  final int note;
  final MovieList movieList;

  RateMovieEvent(this.movieList, {required this.note});
}

// When the user adds a movie to his wishlist
final class WishlistMovieEvent extends MovieDetailsEvent {}

// When the user adds a movie to a custom list
final class CustomListMovieEvent extends MovieDetailsEvent {}
