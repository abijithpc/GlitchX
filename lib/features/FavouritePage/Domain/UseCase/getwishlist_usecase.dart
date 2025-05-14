import 'package:glitchxscndprjt/features/FavouritePage/Data/Models/favourite_model.dart';
import 'package:glitchxscndprjt/features/FavouritePage/Domain/Repository/wishlist_reposiotry.dart';

class GetWishlistUsecase {
  final WishlistReposiotry repository;

  GetWishlistUsecase(this.repository);

  Future<List<FavouriteModel>> call(String userId) {
    return repository.getWishlist(userId);
  }
}