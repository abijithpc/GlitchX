import 'package:glitchxscndprjt/features/Cart_Page/Domain/Repository/cart_repository.dart';

class ClearCartUsecase {
  final CartRepository repository;

  ClearCartUsecase(this.repository);

  Future<void> call(String userId) async {
    return repository.clearCart(userId);
  }
}
