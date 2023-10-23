part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState {}

class WishListLoading extends WishlistState {}

class WishlistAdded extends WishlistState {}

class WishlistRemoved extends WishlistState {}
