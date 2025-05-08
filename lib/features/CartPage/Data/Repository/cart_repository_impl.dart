import 'package:glitchxscndprjt/features/CartPage/Data/DataSource/cartdata_remotesource.dart';
import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/Repository/cart_repository.dart';

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
}
