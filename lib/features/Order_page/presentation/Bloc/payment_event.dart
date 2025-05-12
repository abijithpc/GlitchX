import 'package:glitchxscndprjt/features/Order_page/Data/Models/payment_model.dart';

abstract class PaymentEvent {}

class StartPaymentEvent extends PaymentEvent {
  final PaymentModel paymentModel;

  StartPaymentEvent(this.paymentModel);
}

class PaymentSuccessEvent extends PaymentEvent {
  final String paymentId;
  final PaymentModel request;
  PaymentSuccessEvent({required this.paymentId, required this.request});
}

class PaymentFailureEvent extends PaymentEvent {
  final String message;

  PaymentFailureEvent(this.message);
}
