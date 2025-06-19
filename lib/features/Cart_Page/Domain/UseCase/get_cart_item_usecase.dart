import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/Repository/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<List<CartModel>> call(String userId) =>
      repository.fetchCartItems(userId);
}
