import 'package:glitchxscndprjt/features/FavouritePage/Data/Models/favourite_model.dart';

abstract class WishlistReposiotry {
  Future<void> addToWishlist(FavouriteModel model);
  Future<void> deleteFromWishlist(String userId, String productId);
  Future<List<FavouriteModel>> getWishlist(String userId);
}
