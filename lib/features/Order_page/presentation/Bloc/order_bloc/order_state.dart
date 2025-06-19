import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderPlaced extends OrderState {
  final List<OrderModel> orders;

  OrderPlaced(this.orders);

  List<Object> get props => [orders];
}

class OrderCancelledState extends OrderState {}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}

class OrderDetailsInitial extends OrderState {}

class OrderDetailsLoading extends OrderState {}

class OrderDetailsLoaded extends OrderState {
  final OrderModel order;

  OrderDetailsLoaded(this.order);
}

class OrderDetailsError extends OrderState {
  final String message;

  OrderDetailsError(this.message);
}
