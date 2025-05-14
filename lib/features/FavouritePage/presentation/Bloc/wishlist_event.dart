import 'package:glitchxscndprjt/features/FavouritePage/Data/Models/favourite_model.dart';

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
  DeleteWishListEvent(this.productId, this.userId);
}
