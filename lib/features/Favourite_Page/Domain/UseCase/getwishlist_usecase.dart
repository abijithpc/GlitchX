import 'package:glitchxscndprjt/features/Favourite_Page/Data/Models/favourite_model.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/Repository/wishlist_reposiotry.dart';

class GetWishlistUsecase {
  final WishlistReposiotry repository;

  GetWishlistUsecase(this.repository);

  Future<List<FavouriteModel>> call(String userId) {
    return repository.getWishlist(userId);
  }
}