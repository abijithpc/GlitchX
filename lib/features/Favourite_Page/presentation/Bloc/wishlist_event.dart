import 'package:glitchxscndprjt/features/Favourite_Page/Data/Models/favourite_model.dart';

abstract class WishlistEvent {}

class AddProductToWishList extends WishlistEvent {
  final FavouriteModel model;

  AddProductToWishList(this.model);
}

class LoadWishlistEvent extends WishlistEvent {
  final String userId;

  LoadWishlistEvent(this.userId);
}

class DeleteWishListEvent extends WishlistEvent {
  final String userId;
  final String productId;
  DeleteWishListEvent(this.userId, this.productId);
}
