import 'package:glitchxscndprjt/features/FavouritePage/Data/Models/favourite_model.dart';
import 'package:glitchxscndprjt/features/FavouritePage/Domain/Repository/wishlist_reposiotry.dart';

class AddtowishlistUsecase {
  final WishlistReposiotry reposiotry;

  AddtowishlistUsecase(this.reposiotry);

  Future<void> call(FavouriteModel model) {
    return reposiotry.addToWishlist(model);
  }
}
