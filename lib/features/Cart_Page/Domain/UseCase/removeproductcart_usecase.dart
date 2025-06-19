import 'package:glitchxscndprjt/features/Cart_Page/Domain/Repository/cart_repository.dart';

class RemoveproductcartUsecase {
  final CartRepository cartRepository;

  RemoveproductcartUsecase(this.cartRepository);

  Future<void> call(String userId, String productId) {
    return cartRepository.removeProductsFromCart(userId, productId);
  }
}
