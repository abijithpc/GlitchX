import 'package:glitchxscndprjt/features/Favourite_Page/Domain/Repository/wishlist_reposiotry.dart';

class DeleteFromWishlistUsecase {
  final WishlistReposiotry repository;

  DeleteFromWishlistUsecase(this.repository);

  Future<void> call(String userId, String productId) {
    return repository.deleteFromWishlist(userId, productId);
  }
}
