import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';

abstract class OrderRepository {
  Future<void> placeOrder(List<OrderModel> orders);

  Future<List<OrderModel>> getOrdersByUser(String userId);

  Future<void> cancelOrder(String orderId);
}
