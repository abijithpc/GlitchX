import 'package:glitchxscndprjt/features/FavouritePage/Data/Models/favourite_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<FavouriteModel> wishlist;
  WishlistLoaded(this.wishlist);
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError(this.message);
}
