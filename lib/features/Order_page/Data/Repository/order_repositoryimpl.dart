import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/order_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> placeOrder(List<OrderModel> order) {
    return remoteDataSource.placeOrder(order);
  }

  @override
  Future<List<OrderModel>> getOrdersByUser(String userId) {
    return remoteDataSource.fetchOrdersByUser(userId);
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await remoteDataSource.cancelOrder(orderId);
  }
}
