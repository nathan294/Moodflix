import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/movie_details/data/wishlist.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  // Classic initial stuff
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();

  bool isAddedToWishlist; // initial wishlist status
  final int movieId; // movie ID

  WishlistCubit({required this.isAddedToWishlist, required this.movieId})
      : super(isAddedToWishlist ? WishlistAdded() : WishlistRemoved());

  // Function to toggle wishlist
  void toggleWishlist() async {
    emit(WishListLoading());
    if (isAddedToWishlist) {
      // Call API to remove from wishlist
      bool isSuccessfullyRemoved =
          await removeMovieFromWishlistAPI(movieId, dio);
      if (isSuccessfullyRemoved) {
        isAddedToWishlist = !isAddedToWishlist;
        emit(WishlistRemoved());
      }
    } else {
      // Call API to add to wishlist
      bool isSuccessfullyAdded = await addMovieToWishlistAPI(movieId, dio);
      if (isSuccessfullyAdded) {
        isAddedToWishlist = !isAddedToWishlist;
        emit(WishlistAdded());
      }
    }
  }
}
