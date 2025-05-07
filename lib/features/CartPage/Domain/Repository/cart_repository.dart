import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';

abstract class CartRepository {
  Future<void> addProductToCart(CartModel cart);
  Future<List<CartModel>> fetchCartItems(String userId);
}
