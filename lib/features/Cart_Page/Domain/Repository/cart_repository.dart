import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';

abstract class CartRepository {
  Future<void> addProductToCart(CartModel cart);

  Future<List<CartModel>> fetchCartItems(String userId);

  Future<void> removeProductsFromCart(String userId, String productId);

  Future<void> clearCart(String userId);
}
