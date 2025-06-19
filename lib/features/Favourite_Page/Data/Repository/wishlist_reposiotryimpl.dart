import 'package:glitchxscndprjt/features/Favourite_Page/Data/DataSource/wishlist_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Data/Models/favourite_model.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/Repository/wishlist_reposiotry.dart';

class WishlistReposiotryimpl implements WishlistReposiotry {
  final WishlistRemotedatasource remotedatasource;

  WishlistReposiotryimpl(this.remotedatasource);

  @override
  Future<void> addToWishlist(FavouriteModel model) {
    return remotedatasource.addToWishList(model);
  }

  @override
  Future<List<FavouriteModel>> getWishlist(String userId) {
    return remotedatasource.getWishList(userId);
  }

  @override
  Future<void> deleteFromWishlist(String userId, String productId) {
    return remotedatasource.deleteFromWishList(userId, productId);
  }
}
