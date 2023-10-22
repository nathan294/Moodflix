import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movie_details/bloc/details_bloc.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        bool isLoading = false;
        bool isAddedToWishlist = false;

        // Determine button state based on BLoC state
        if (state is WishlistUpdatingState) {
          isLoading = true;
        } else if (state is WishlistUpdatedState) {
          isAddedToWishlist = state.isAddedToWishlist;
        }

        // Determine button icon based on whether the movie is in the wishlist
        final icon = isAddedToWishlist ? Icons.favorite : Icons.favorite_border;

        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  // Send ToggleWishlistEvent to BLoC when button is clicked
                  BlocProvider.of<MovieDetailsBloc>(context)
                      .add(ToggleWishlistEvent());
                },
          child: isLoading
              ? const CircularProgressIndicator()
              : Icon(
                  icon,
                  color: isAddedToWishlist ? Colors.red : Colors.grey,
                ),
        );
      },
    );
  }
}
