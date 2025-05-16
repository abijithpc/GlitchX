import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';

abstract class OrderEvent {}

class PlaceOrderEvent extends OrderEvent {
  final List<OrderModel> models;

  PlaceOrderEvent(this.models);
}

class ResetOrderState extends OrderEvent {}
