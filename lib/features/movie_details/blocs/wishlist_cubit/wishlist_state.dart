part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState {}

class WishListLoading extends WishlistState {}

// When movie has been wished by the user
class WishlistAdded extends WishlistState {}

// When movie isn't wished by the user
class WishlistRemoved extends WishlistState {}

// When movie has been rated by the user, wishlist button becomes unavailable
class WishlistUnavailable extends WishlistState {}
