import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';

abstract class OrderEvent {}

class PlaceOrderEvent extends OrderEvent {
  final List<OrderModel> models;
  final String userId;

  PlaceOrderEvent(this.models, this.userId);
}

class ResetOrderState extends OrderEvent {}

class FetchOrders extends OrderEvent {
  final String userId;

  FetchOrders(this.userId);
}

class CancelOrderEvent extends OrderEvent {
  String orderId;

  CancelOrderEvent(this.orderId);

  List<Object> get props => [orderId];
}
