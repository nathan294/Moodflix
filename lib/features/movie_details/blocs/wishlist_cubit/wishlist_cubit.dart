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
  Future<void> toggleWishlist({bool? isMovieRated}) async {
    emit(WishListLoading());
    if (isAddedToWishlist) {
      // Call API to remove from wishlist
      bool isSuccessfullyRemoved =
          await removeMovieFromWishlistAPI(movieId, dio);
      if (isSuccessfullyRemoved) {
        isAddedToWishlist = !isAddedToWishlist;
        if (isMovieRated != null && isMovieRated) {
          emit(WishlistUnavailable());
        } else {
          emit(WishlistRemoved());
        }
      } else {
        // Revert back the isAddedToWishlist flag if the operation failed
        isAddedToWishlist = !isAddedToWishlist;
        emit(WishlistAdded());
      }
    } else {
      // Call API to add to wishlist
      bool isSuccessfullyAdded = await addMovieToWishlistAPI(movieId, dio);
      if (isSuccessfullyAdded) {
        isAddedToWishlist = !isAddedToWishlist;
        emit(WishlistAdded());
      } else {
        // Revert back the isAddedToWishlist flag if the operation failed
        isAddedToWishlist = !isAddedToWishlist;
        emit(WishlistRemoved());
      }
    }
  }

  Future<void> toggleWishlistAvailability({required bool isMovieRated}) async {
    if (isMovieRated) {
      // If the movie is rated, make the wishlist button unavailable
      emit(WishlistUnavailable());
    } else {
      // When movie is no longer rated, allow the user to wish the movie again
      emit(WishlistRemoved());
    }
  }
}
