part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitialState extends RatingState {}

// When rating is being processed (calling API etc...)
class RatingLoading extends RatingState {}

// When user is currently rating the movie (i.e. he's chosing the rating he wants)
class UserCurrentlyRating extends RatingState {}

// When the movie is rated by the user
class MovieRated extends RatingState {}

// When the movie isn't rated by the user
class MovieNotRated extends RatingState {}
