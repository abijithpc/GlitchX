import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/Repository/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(CartModel cart) => repository.addProductToCart(cart);
}
