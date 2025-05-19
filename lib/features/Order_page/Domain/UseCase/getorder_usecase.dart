import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/order_repository.dart';

class GetUserOrdersUseCase {
  final OrderRepository repository;

  GetUserOrdersUseCase(this.repository);

  Future<List<OrderModel>> call(String userId) {
    return repository.getOrdersByUser(userId);
  }
}
