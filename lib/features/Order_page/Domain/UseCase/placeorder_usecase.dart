import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/order_repository.dart';

class PlaceOrderUsecase {
  final OrderRepository repository;

  PlaceOrderUsecase(this.repository);

  Future<void> call(List<OrderModel> orders) async {
    print("✅ UseCase received ${orders.length} orders");
    await repository.placeOrder(orders);
  }
}
