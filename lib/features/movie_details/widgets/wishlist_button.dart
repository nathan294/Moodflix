import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/movie_details/blocs/wishlist_cubit/wishlist_cubit.dart';

class WishlistButton extends StatelessWidget {
  final bool isAddedToWishlist;
  final int movieId;

  const WishlistButton({
    Key? key,
    required this.isAddedToWishlist,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishlistCubit, WishlistState>(
      listener: (context, state) {
        if (state is WishlistRemoved) {
          // Reload CollectionBloc data
          BlocProvider.of<CollectionBloc>(context).add(LoadInitialData());
        }
        if (state is WishlistAdded) {
          // Reload CollectionBloc data
          BlocProvider.of<CollectionBloc>(context).add(LoadInitialData());
        }
      },
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          // Variable to display the right information
          late bool isAddedToWishlist;
          if (state is WishListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistAdded) {
            isAddedToWishlist = true;
          } else {
            isAddedToWishlist = false;
          }

          final icon = isAddedToWishlist
              ? Icons.bookmark_added_rounded
              : Icons.bookmark_border_rounded;

          return ElevatedButton(
            onPressed: () =>
                BlocProvider.of<WishlistCubit>(context).toggleWishlist(),
            child: Icon(
              icon,
              color: isAddedToWishlist ? Colors.red : Colors.black,
            ),
          );
        },
      ),
    );
  }
}
