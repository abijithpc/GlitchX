import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/order_repository.dart';

class CancelorderUsecase {
  final OrderRepository repository;

  CancelorderUsecase(this.repository);

  Future<void> call(String orderId) async{
    await repository.cancelOrder(orderId);
  }
  
}