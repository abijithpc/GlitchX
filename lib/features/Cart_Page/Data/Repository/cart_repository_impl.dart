import 'package:glitchxscndprjt/features/Cart_Page/Data/DataSource/cartdata_remotesource.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/Repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addProductToCart(CartModel cart) =>
      remoteDataSource.addProductToCart(cart);

  @override
  Future<List<CartModel>> fetchCartItems(String userId) =>
      remoteDataSource.fetchCartItems(userId);

  @override
  Future<void> removeProductsFromCart(String userId, String productId) {
    return remoteDataSource.removeCartItems(userId, productId);
  }

  @override
  Future<void> clearCart(String userId) async {
    return remoteDataSource.clearCart(userId);
  }
}
