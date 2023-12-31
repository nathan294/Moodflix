import 'package:flutter/widgets.dart';
import 'package:moodflix/features/movie_details/blocs/bloc/details_bloc.dart';
import 'package:moodflix/features/movie_details/widgets/rate_button.dart';
import 'package:moodflix/features/movie_details/widgets/wishlist_button.dart';
import 'package:moodflix/features/movie_search/models/movie.dart';

class ButtonsRow extends StatelessWidget {
  final DataLoadedState state;
  final Movie movie;
  const ButtonsRow({super.key, required this.state, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RateButton(selectedRating: state.rate),
        WishlistButton(
          isAddedToWishlist: state.isWished,
          movieId: movie.id,
        )
      ],
    );
  }
}
